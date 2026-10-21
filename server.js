
const express = require('express');
const Database = require('better-sqlite3');
const path = require('path');

const app = express();
const PORT = 3000;

// JSON 데이터 받기
app.use(express.json());

// SQLite 데이터베이스 연결
const dbPath = path.join(__dirname, 'database', 'myongjimap.db');
const db = new Database(dbPath);
console.log('연결된 DB 파일:', dbPath);

// 외래 키 검사 활성화
db.pragma('foreign_keys = ON');

// 좌표 등록 도구 화면 제공
app.use(express.static(path.join(__dirname, 'coordinate-tool')));

// 서버 상태 확인
app.get('/api/health', (req, res) => {
    res.json({ message: '서버가 정상적으로 실행 중입니다.' });
});

// 등록된 노드 확인
app.get('/api/nodes', (req, res) => {
    const nodes = db.prepare('SELECT * FROM nodes').all();
    res.json(nodes);
});


app.delete('/api/nodes/:id', (req, res) => {
    try {
        const nodeId = Number(req.params.id);

        if (!Number.isInteger(nodeId) || nodeId <= 0) {
            return res.status(400).json({
                error: '올바르지 않은 노드 ID입니다.'
            });
        }

        const result = db.prepare(
            'DELETE FROM nodes WHERE node_id = ?'
        ).run(nodeId);

        if (result.changes === 0) {
            return res.status(404).json({
                error: '삭제할 노드를 찾을 수 없습니다.'
            });
        }

        res.json({
            message: '노드가 삭제되었습니다.'
        });
    } catch (error) {
        console.error('노드 삭제 오류:', error.message);
        res.status(500).json({
            error: '노드 삭제에 실패했습니다.'
        });
    }
});


// 서버 실행
app.listen(PORT, () => {
    console.log(`서버 실행 주소: http://localhost:${PORT}`);
});


/* 노드 좌표를 데이터베이스에 저장 */
app.post('/api/nodes', (req, res) => {
    try {
        const {
            building_id,
            floor_id,
            node_name,
            node_type,
            x,
            y
        } = req.body;

        // 필수 데이터 확인
        if (
            !building_id ||
            !floor_id ||
            !node_type ||
            x === undefined ||
            y === undefined
        ) {
            return res.status(400).json({
                error: '건물, 층, 노드 유형, x, y 좌표가 필요합니다.'
            });
        }

        // 허용된 노드 유형 확인
        const allowedTypes = [
            'ENTRANCE',
            'CORRIDOR',
            'CLASSROOM',
            'ELEVATOR'
        ];

        if (!allowedTypes.includes(node_type)) {
            return res.status(400).json({
                error: '올바르지 않은 노드 유형입니다.'
            });
        }

        // SQLite에 노드 저장
        const stmt = db.prepare(`
            INSERT INTO nodes (
                building_id,
                floor_id,
                node_name,
                node_type,
                x,
                y
            )
            VALUES (?, ?, ?, ?, ?, ?)
        `);

        const result = stmt.run(
            building_id,
            floor_id,
            node_name || null,
            node_type,
            Number(x),
            Number(y)
        );

        res.status(201).json({
            message: '노드 좌표가 저장되었습니다.',
            node_id: result.lastInsertRowid
        });

    } catch (error) {
        console.error('노드 저장 오류:', error.message);

        res.status(500).json({
            error: '노드 저장에 실패했습니다. 건물과 층 정보도 확인해 주세요.'
        });
    }
});

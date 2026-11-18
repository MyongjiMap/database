-- 1. 건물 기본 정보
INSERT OR IGNORE INTO buildings (building_id, building_name)
VALUES
    ('Y05', '제5공학관'),
    ('Y09', '함박관'),
    ('Y02', '창조관');

-- 2. 층 기본 정보 (함박관 B1층은 floor = 0)
INSERT OR IGNORE INTO floors
(floor_id, building_id, floor, floor_name, svg_url)
VALUES
    ('Y05_1F', 'Y05', 1, '1층', 'svg/5공학관_1F.svg'),
    ('Y05_4F', 'Y05', 4, '4층', 'svg/5공학관_4F.svg'),

    ('Y09_B1F', 'Y09', 0, 'B1층', 'svg/함박관_B1F.svg'),
    ('Y09_1F', 'Y09', 1, '1층', 'svg/함박관_1F.svg'),
    ('Y09_2F', 'Y09', 2, '2층', 'svg/함박관_2F.svg'),
    ('Y09_3F', 'Y09', 3, '3층', 'svg/함박관_3F.svg'),
    ('Y09_4F', 'Y09', 4, '4층', 'svg/함박관_4F.svg'),
    ('Y09_5F', 'Y09', 5, '5층', 'svg/함박관_5F.svg'),

    ('Y02_4F', 'Y02', 4, '4층', 'svg/창조관_4F.svg'),
    ('Y02_5F', 'Y02', 5, '5층', 'svg/창조관_5F.svg');

-- 이미 B1층이 다른 값으로 들어간 DB를 위한 보정 (INSERT OR IGNORE는 기존 행을 바꾸지 않음)
UPDATE floors SET floor = 0 WHERE floor_id = 'Y09_B1F' AND floor <> 0;


-- 3. 편의시설 기본 정보
-- 시설 코드가 이미 존재하면 중복 등록하지 않음
INSERT OR IGNORE INTO facilities
(building_id, floor_id, facility_type, facility_name, facility_code, x, y)
VALUES
    -- 제5공학관
    ('Y05', 'Y05_1F', 'PRINT', '프린터', 'Y05_1F_PRINT_01', 180, 212.5),
    ('Y05', 'Y05_1F', 'TOILET', '화장실', 'Y05_1F_TOILET_01', 607.5, 212.5),
    ('Y05', 'Y05_4F', 'TOILET', '화장실', 'Y05_4F_TOILET_01', 254, 212.5),

    -- 함박관
    ('Y09', 'Y09_B1F', 'TOILET', '화장실', 'Y09_B1F_TOILET_01', 722.5, 370),
    ('Y09', 'Y09_1F', 'TOILET', '화장실', 'Y09_1F_TOILET_01', 700, 370),
    ('Y09', 'Y09_2F', 'TOILET', '화장실', 'Y09_2F_TOILET_01', 704, 370),
    ('Y09', 'Y09_3F', 'CAFE', '카페', 'Y09_3F_CAFE_01', 543, 112.5),
    ('Y09', 'Y09_3F', 'TOILET', '화장실', 'Y09_3F_TOILET_01', 703.5, 370),
    ('Y09', 'Y09_4F', 'PRINT', '프린터', 'Y09_4F_PRINT_01', 380, 292),
    ('Y09', 'Y09_4F', 'TOILET', '화장실', 'Y09_4F_TOILET_01', 703.5, 370),
    ('Y09', 'Y09_5F', 'TOILET', '화장실', 'Y09_5F_TOILET_01', 702, 370),

    -- 창조관
    ('Y02', 'Y02_4F', 'TOILET', '화장실', 'Y02_4F_TOILET_01', 116.5, 667.5),
    ('Y02', 'Y02_5F', 'PRINT', '프린터', 'Y02_5F_PRINT_01', 364, 174),
    ('Y02', 'Y02_5F', 'TOILET', '화장실', 'Y02_5F_TOILET_01', 84, 562),
    ('Y02', 'Y02_5F', 'TOILET', '화장실', 'Y02_5F_TOILET_02', 366, 92);

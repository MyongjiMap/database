
-- 1. 건물 기본 정보
INSERT OR IGNORE INTO buildings (building_id, building_name)
VALUES
    ('Y05', '제5공학관'),
    ('Y09', '함박관'),
    ('Y02', '창조관');

-- 2. 층 기본 정보
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

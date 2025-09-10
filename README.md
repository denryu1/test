-- 映画作品テーブル
CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL
);

-- 上映スケジュールテーブル
CREATE TABLE schedules (
    id SERIAL PRIMARY KEY,
    movie_id INT NOT NULL REFERENCES movies(id) ON DELETE CASCADE,
    show_time TIMESTAMP NOT NULL
);

-- 座席テーブル
CREATE TABLE seats (
    id SERIAL PRIMARY KEY,
    schedule_id INT NOT NULL REFERENCES schedules(id) ON DELETE CASCADE,
    seat_number VARCHAR(10) NOT NULL,
    is_reserved BOOLEAN DEFAULT FALSE
);

-- 予約テーブル
CREATE TABLE reservations (
    id SERIAL PRIMARY KEY,
    schedule_id INT NOT NULL REFERENCES schedules(id) ON DELETE CASCADE,
    seat_id INT NOT NULL REFERENCES seats(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL
);

-- 映画データ
INSERT INTO movies(title) VALUES
('アバター:ウェイ・オブ・ウォーター'),
('君の名は'),
('ハリー・ポッターと賢者の石');

-- 上映スケジュールデータ
INSERT INTO schedules(movie_id, show_time) VALUES
(1, '2025-09-10 10:00'),
(1, '2025-09-10 14:00'),
(2, '2025-09-10 11:00'),
(3, '2025-09-10 13:00');

-- 座席データ（例：A1～A10, B1～B10）
DO $$
BEGIN
    FOR r IN 1..2 LOOP
        FOR n IN 1..10 LOOP
            INSERT INTO seats(schedule_id, seat_number)
            VALUES (r, chr(64+r)||n);
        END LOOP;
    END LOOP;
END$$;

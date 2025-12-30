-- =========================================
-- Keswa Volunteer Evaluation System
-- Database Schema (PostgreSQL)
-- =========================================

-- ======================
-- Users (Admin / Evaluator)
-- ======================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(20) CHECK (role IN ('admin', 'evaluator')) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- Volunteers
-- ======================
CREATE TABLE volunteers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    join_date DATE,
    role VARCHAR(50),
    status VARCHAR(20) CHECK (status IN ('active', 'freezed', 'stopped')) DEFAULT 'active',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- Volunteer Notes (Cumulative)
-- ======================
CREATE TABLE volunteer_notes (
    id SERIAL PRIMARY KEY,
    volunteer_id INT REFERENCES volunteers(id) ON DELETE CASCADE,
    note TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- Evaluation Criteria
-- ======================
CREATE TABLE criteria (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    type VARCHAR(20) CHECK (type IN ('numeric', 'text', 'boolean')) NOT NULL,
    weight INT DEFAULT 0,
    is_required BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- Evaluations (Monthly)
-- ======================
CREATE TABLE evaluations (
    id SERIAL PRIMARY KEY,
    volunteer_id INT REFERENCES volunteers(id) ON DELETE CASCADE,
    evaluator_id INT REFERENCES users(id),
    month INT CHECK (month BETWEEN 1 AND 12),
    year INT,
    total_score DECIMAL(5,2),
    human_feedback TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (volunteer_id, month, year)
);

-- ======================
-- Evaluation Items (Details)
-- ======================
CREATE TABLE evaluation_items (
    id SERIAL PRIMARY KEY,
    evaluation_id INT REFERENCES evaluations(id) ON DELETE CASCADE,
    criteria_id INT REFERENCES criteria(id),
    value TEXT,
    score DECIMAL(5,2)
);

-- ======================
-- Freeze System
-- ======================
CREATE TABLE freezes (
    id SERIAL PRIMARY KEY,
    volunteer_id INT REFERENCES volunteers(id) ON DELETE CASCADE,
    reason TEXT,
    from_date DATE,
    to_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- Alerts (Smart Notifications)
-- ======================
CREATE TABLE alerts (
    id SERIAL PRIMARY KEY,
    volunteer_id INT REFERENCES volunteers(id) ON DELETE CASCADE,
    type VARCHAR(50),
    description TEXT,
    resolved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

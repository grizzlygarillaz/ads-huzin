-- ----------------------------
-- Table structure for resolvers
-- ----------------------------
CREATE TABLE resolvers (
    key VARCHAR(55) PRIMARY KEY,
    description VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

-- ----------------------------
-- Table structure for param_types
-- ----------------------------
CREATE TABLE param_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(55) NOT NULL UNIQUE
);

-- ----------------------------
-- Table structure for params
-- ----------------------------
CREATE TABLE params (
    id SERIAL PRIMARY KEY,
    key VARCHAR(55) NOT NULL,
    default_value VARCHAR(255),
    param_type_id INT NOT NULL REFERENCES param_types(id) ON DELETE CASCADE,
    "order" SMALLINT DEFAULT 0,
    resolver VARCHAR(55) NOT NULL REFERENCES resolvers(key) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE(key, resolver)
);

-- ----------------------------
-- Table structure for param_values
-- ----------------------------
CREATE TABLE param_values (
    id SERIAL PRIMARY KEY,
    key VARCHAR(55) NOT NULL,
    value VARCHAR(255),
    param_id INT NOT NULL REFERENCES params(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE(param_id, key)
);

-- ----------------------------
-- Table structure for projects
-- ----------------------------
CREATE TABLE projects (
    uuid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

-- ----------------------------
-- Table structure for channels
-- ----------------------------
CREATE TABLE channels (
    id SERIAL PRIMARY KEY,
    uuid UUID NOT NULL UNIQUE DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects(uuid) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,
    name VARCHAR(255),
    identifier VARCHAR(255),
    settings JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE(project_id, type, identifier)
);

-- ----------------------------
-- Table structure for variable_definitions
-- ----------------------------
CREATE TABLE variable_definitions (
    key VARCHAR(55) PRIMARY KEY,
    default_value VARCHAR(255),
    description VARCHAR(255),
    required BOOLEAN DEFAULT TRUE,
    overridable BOOLEAN DEFAULT FALSE,
    project_uuid UUID REFERENCES projects(uuid) ON DELETE CASCADE,
    channel_id INT REFERENCES channels(id) ON DELETE CASCADE,
    resolver VARCHAR(55) NOT NULL REFERENCES resolvers(key) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE(project_uuid, channel_id, key)
);

-- ----------------------------
-- Table structure for variables
-- ----------------------------
CREATE TABLE variables (
    id SERIAL PRIMARY KEY,
    value VARCHAR(255),
    project_uuid UUID NOT NULL REFERENCES projects(uuid) ON DELETE CASCADE,
    channel_id INT REFERENCES channels(id) ON DELETE CASCADE,
    key VARCHAR(55) NOT NULL REFERENCES variable_definitions(key) ON DELETE CASCADE,
    resolver VARCHAR(55) REFERENCES resolvers(key) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE(project_uuid, channel_id, key)
);

CREATE INDEX idx_variables_project_channel ON variables(project_uuid, channel_id);

-- ----------------------------
-- Table structure for variable_param_values
-- ----------------------------
CREATE TABLE variable_param_values (
    id SERIAL PRIMARY KEY,
    value VARCHAR(255),
    param_id INT NOT NULL REFERENCES params(id) ON DELETE CASCADE,
    variable_id INT NOT NULL REFERENCES variables(id) ON DELETE CASCADE,
    param_value_id INT REFERENCES param_values(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE(variable_id, param_id)
);

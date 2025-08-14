# Initialize Platform Core - Spring Boot Java Project (WITHOUT LOMBOK)
# This script creates the initial Spring Boot project structure

param(
    [Parameter(Mandatory=$false)]
    [string]$ProjectPath = "C:\dev\git\nooma-digital\nooma-ai-backend",
    
    [Parameter(Mandatory=$false)]
    [string]$OrgName = "nooma-digital"
)

Write-Host "ðŸš€ Initializing Nooma AI Backend (Spring Boot - NO LOMBOK)" -ForegroundColor Cyan

# Create project directory
if (-not (Test-Path $ProjectPath)) {
    New-Item -ItemType Directory -Path $ProjectPath -Force
}

Set-Location $ProjectPath

# Create pom.xml (WITHOUT LOMBOK)
$pomContent = @'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.0</version>
        <relativePath/>
    </parent>
    
    <groupId>com.nooma</groupId>
    <artifactId>nooma-ai-backend</artifactId>
    <version>0.1.0-SNAPSHOT</version>
    <name>Nooma AI Backend</name>
    <description>Backend API for Nooma AI by Nooma Digital</description>
    
    <properties>
        <java.version>21</java.version>
        <spring-cloud.version>2023.0.0</spring-cloud.version>
        <testcontainers.version>1.19.3</testcontainers.version>
        <springdoc.version>2.3.0</springdoc.version>
    </properties>
    
    <dependencies>
        <!-- Spring Boot Starters -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-cache</artifactId>
        </dependency>
        
        <!-- Database -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>com.pgvector</groupId>
            <artifactId>pgvector</artifactId>
            <version>0.1.4</version>
        </dependency>
        <dependency>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-core</artifactId>
        </dependency>
        
        <!-- Redis -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>
        
        <!-- JWT -->
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-api</artifactId>
            <version>0.12.3</version>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-impl</artifactId>
            <version>0.12.3</version>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-jackson</artifactId>
            <version>0.12.3</version>
            <scope>runtime</scope>
        </dependency>
        
        <!-- OpenAPI Documentation -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
            <version>${springdoc.version}</version>
        </dependency>
        
        <!-- Azure SDK -->
        <dependency>
            <groupId>com.azure</groupId>
            <artifactId>azure-ai-openai</artifactId>
            <version>1.0.0-beta.6</version>
        </dependency>
        <dependency>
            <groupId>com.azure</groupId>
            <artifactId>azure-storage-blob</artifactId>
            <version>12.25.1</version>
        </dependency>
        
        <!-- Apache Commons -->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
        </dependency>
        
        <!-- Testing -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.security</groupId>
            <artifactId>spring-security-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>testcontainers</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>postgresql</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>
        
        <!-- Dev Tools -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <release>21</release>
                    <parameters>true</parameters>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
'@

$pomContent | Out-File -FilePath "pom.xml" -Encoding UTF8

# Create directory structure
$directories = @(
    "src/main/java/com/nooma/platform",
    "src/main/java/com/nooma/platform/auth/api/rest/v1/controller",
    "src/main/java/com/nooma/platform/auth/api/rest/v1/dto/request",
    "src/main/java/com/nooma/platform/auth/api/rest/v1/dto/response",
    "src/main/java/com/nooma/platform/auth/domain/model",
    "src/main/java/com/nooma/platform/auth/domain/service",
    "src/main/java/com/nooma/platform/auth/domain/port",
    "src/main/java/com/nooma/platform/auth/infrastructure/adapters/database",
    "src/main/java/com/nooma/platform/auth/infrastructure/config",
    "src/main/java/com/nooma/platform/common/exception",
    "src/main/java/com/nooma/platform/common/util",
    "src/main/resources",
    "src/main/resources/db/migration",
    "src/test/java/com/nooma/platform",
    "src/test/resources"
)

foreach ($dir in $directories) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

# Create main application class
$mainAppContent = @'
package com.nooma.platform;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableCaching
@EnableAsync
@EnableScheduling
public class PlatformCoreApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(PlatformCoreApplication.class, args);
    }
}
'@

$mainAppContent | Out-File -FilePath "src/main/java/com/nooma/platform/PlatformCoreApplication.java" -Encoding UTF8

# Create User model WITHOUT LOMBOK
$userModelContent = @'
package com.nooma.platform.auth.domain.model;

import java.time.Instant;
import java.util.Set;
import java.util.UUID;

public class User {
    private UUID id;
    private UUID organizationId;
    private String email;
    private String passwordHash;
    private String fullName;
    private String phone;
    private Set<Role> roles;
    private Boolean active;
    private Boolean emailVerified;
    private Instant lastLoginAt;
    private Instant createdAt;
    private Instant updatedAt;
    
    // Default constructor
    public User() {}
    
    // Constructor with all fields
    public User(UUID id, UUID organizationId, String email, String passwordHash, 
                String fullName, String phone, Set<Role> roles, Boolean active, 
                Boolean emailVerified, Instant lastLoginAt, Instant createdAt, 
                Instant updatedAt) {
        this.id = id;
        this.organizationId = organizationId;
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.phone = phone;
        this.roles = roles;
        this.active = active;
        this.emailVerified = emailVerified;
        this.lastLoginAt = lastLoginAt;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Getters
    public UUID getId() {
        return id;
    }
    
    public UUID getOrganizationId() {
        return organizationId;
    }
    
    public String getEmail() {
        return email;
    }
    
    public String getPasswordHash() {
        return passwordHash;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public Set<Role> getRoles() {
        return roles;
    }
    
    public Boolean getActive() {
        return active;
    }
    
    public Boolean getEmailVerified() {
        return emailVerified;
    }
    
    public Instant getLastLoginAt() {
        return lastLoginAt;
    }
    
    public Instant getCreatedAt() {
        return createdAt;
    }
    
    public Instant getUpdatedAt() {
        return updatedAt;
    }
    
    // Setters
    public void setId(UUID id) {
        this.id = id;
    }
    
    public void setOrganizationId(UUID organizationId) {
        this.organizationId = organizationId;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
    
    public void setActive(Boolean active) {
        this.active = active;
    }
    
    public void setEmailVerified(Boolean emailVerified) {
        this.emailVerified = emailVerified;
    }
    
    public void setLastLoginAt(Instant lastLoginAt) {
        this.lastLoginAt = lastLoginAt;
    }
    
    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }
    
    public void setUpdatedAt(Instant updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    // Builder pattern WITHOUT LOMBOK
    public static Builder builder() {
        return new Builder();
    }
    
    public static class Builder {
        private UUID id;
        private UUID organizationId;
        private String email;
        private String passwordHash;
        private String fullName;
        private String phone;
        private Set<Role> roles;
        private Boolean active;
        private Boolean emailVerified;
        private Instant lastLoginAt;
        private Instant createdAt;
        private Instant updatedAt;
        
        public Builder id(UUID id) {
            this.id = id;
            return this;
        }
        
        public Builder organizationId(UUID organizationId) {
            this.organizationId = organizationId;
            return this;
        }
        
        public Builder email(String email) {
            this.email = email;
            return this;
        }
        
        public Builder passwordHash(String passwordHash) {
            this.passwordHash = passwordHash;
            return this;
        }
        
        public Builder fullName(String fullName) {
            this.fullName = fullName;
            return this;
        }
        
        public Builder phone(String phone) {
            this.phone = phone;
            return this;
        }
        
        public Builder roles(Set<Role> roles) {
            this.roles = roles;
            return this;
        }
        
        public Builder active(Boolean active) {
            this.active = active;
            return this;
        }
        
        public Builder emailVerified(Boolean emailVerified) {
            this.emailVerified = emailVerified;
            return this;
        }
        
        public Builder lastLoginAt(Instant lastLoginAt) {
            this.lastLoginAt = lastLoginAt;
            return this;
        }
        
        public Builder createdAt(Instant createdAt) {
            this.createdAt = createdAt;
            return this;
        }
        
        public Builder updatedAt(Instant updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }
        
        public User build() {
            return new User(id, organizationId, email, passwordHash, fullName, 
                          phone, roles, active, emailVerified, lastLoginAt, 
                          createdAt, updatedAt);
        }
    }
}
'@

$userModelContent | Out-File -FilePath "src/main/java/com/nooma/platform/auth/domain/model/User.java" -Encoding UTF8

# Create Role enum
$roleContent = @'
package com.nooma.platform.auth.domain.model;

public enum Role {
    SUPER_ADMIN,
    ADMIN,
    MANAGER,
    USER,
    VIEWER
}
'@

$roleContent | Out-File -FilePath "src/main/java/com/nooma/platform/auth/domain/model/Role.java" -Encoding UTF8

# Create application.yml
$appYmlContent = @'
spring:
  application:
    name: nooma-platform-core
  
  profiles:
    active: ${SPRING_PROFILES_ACTIVE:dev}
  
  datasource:
    url: jdbc:postgresql://${DB_HOST:localhost}:5432/${DB_NAME:nooma}
    username: ${DB_USER:nooma}
    password: ${DB_PASSWORD:nooma123}
    hikari:
      maximum-pool-size: 10
      minimum-idle: 5
      connection-timeout: 30000
  
  jpa:
    hibernate:
      ddl-auto: validate
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
    show-sql: false
  
  flyway:
    enabled: true
    baseline-on-migrate: true
    locations: classpath:db/migration
  
  redis:
    host: ${REDIS_HOST:localhost}
    port: ${REDIS_PORT:6379}
    password: ${REDIS_PASSWORD:}
    timeout: 2000ms
  
  security:
    jwt:
      secret: ${JWT_SECRET:your-256-bit-secret-key-for-development-only-change-in-production}
      expiration: 900000 # 15 minutes
      refresh-expiration: 604800000 # 7 days

server:
  port: ${SERVER_PORT:8080}
  servlet:
    context-path: /api

springdoc:
  api-docs:
    path: /v3/api-docs
  swagger-ui:
    path: /swagger-ui.html
    enabled: true

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  metrics:
    export:
      prometheus:
        enabled: true

logging:
  level:
    com.nooma.platform: DEBUG
    org.springframework.security: DEBUG
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
'@

$appYmlContent | Out-File -FilePath "src/main/resources/application.yml" -Encoding UTF8

# Create application-dev.yml
$appDevYmlContent = @'
spring:
  jpa:
    show-sql: true
  
  devtools:
    restart:
      enabled: true
    livereload:
      enabled: true

logging:
  level:
    com.nooma.platform: DEBUG
    org.hibernate.SQL: DEBUG
    org.hibernate.type.descriptor.sql.BasicBinder: TRACE
'@

$appDevYmlContent | Out-File -FilePath "src/main/resources/application-dev.yml" -Encoding UTF8

# Create first Flyway migration
$migrationContent = @'
-- V001__create_initial_schema.sql

-- Create organizations table
CREATE TABLE IF NOT EXISTS organizations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    domain VARCHAR(255) UNIQUE,
    settings JSONB DEFAULT '{}',
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    active BOOLEAN DEFAULT true,
    email_verified BOOLEAN DEFAULT false,
    last_login_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_users_email_org UNIQUE(email, organization_id)
);

-- Create user_roles table
CREATE TABLE IF NOT EXISTS user_roles (
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50) NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, role)
);

-- Create indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_organization ON users(organization_id);
CREATE INDEX idx_users_active ON users(active) WHERE active = true;

-- Create update trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_organizations_updated_at BEFORE UPDATE
    ON organizations FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();

CREATE TRIGGER update_users_updated_at BEFORE UPDATE
    ON users FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();
'@

$migrationContent | Out-File -FilePath "src/main/resources/db/migration/V001__create_initial_schema.sql" -Encoding UTF8

# Create docker-compose.yml
$dockerComposeContent = @'
version: '3.8'

services:
  postgres:
    image: pgvector/pgvector:pg16
    container_name: nooma-postgres
    environment:
      POSTGRES_DB: nooma
      POSTGRES_USER: nooma
      POSTGRES_PASSWORD: nooma123
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - nooma-network

  redis:
    image: redis:7-alpine
    container_name: nooma-redis
    ports:
      - "6379:6379"
    networks:
      - nooma-network

  app:
    build: .
    container_name: nooma-app
    depends_on:
      - postgres
      - redis
    environment:
      SPRING_PROFILES_ACTIVE: dev
      DB_HOST: postgres
      DB_NAME: nooma
      DB_USER: nooma
      DB_PASSWORD: nooma123
      REDIS_HOST: redis
    ports:
      - "8080:8080"
    networks:
      - nooma-network

volumes:
  postgres_data:

networks:
  nooma-network:
    driver: bridge
'@

$dockerComposeContent | Out-File -FilePath "docker-compose.yml" -Encoding UTF8

# Create Dockerfile
$dockerfileContent = @'
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN apk add --no-cache maven && \
    mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
'@

$dockerfileContent | Out-File -FilePath "Dockerfile" -Encoding UTF8

# Create .gitignore
$gitignoreContent = @'
# Compiled class file
*.class

# Log file
*.log

# Package Files
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar

# Maven
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties

# IDE
.idea/
*.iml
*.iws
*.ipr
.project
.settings/
.classpath
.vscode/

# OS
.DS_Store
Thumbs.db

# Application
application-local.yml
application-*.yml
!application-dev.yml
!application-prod.yml
'@

$gitignoreContent | Out-File -FilePath ".gitignore" -Encoding UTF8

# Create README.md
$readmeContent = @'
# Nooma AI Backend

Backend API for Nooma AI by Nooma Digital, built with Spring Boot 3.2 and Java 21.

## ðŸš€ Quick Start

### Prerequisites
- Java 21
- Maven 3.8+
- Docker & Docker Compose
- PostgreSQL 16 with pgvector extension

### Local Development

1. Start dependencies:
```bash
docker-compose up -d postgres redis
```

2. Run the application:
```bash
mvn spring-boot:run
```

3. Access Swagger UI:
http://localhost:8080/api/swagger-ui.html

### Building

```bash
mvn clean package
```

### Running with Docker

```bash
docker-compose up
```

## ðŸ“ Project Structure

```
src/
â”œâ”€â”€ main/
â”‚   â”œâ”€â”€ java/com/nooma/platform/
â”‚   â”‚   â”œâ”€â”€ auth/           # Authentication module
â”‚   â”‚   â”œâ”€â”€ chat/           # Chat module
â”‚   â”‚   â”œâ”€â”€ documents/      # Document processing
â”‚   â”‚   â””â”€â”€ common/         # Shared utilities
â”‚   â””â”€â”€ resources/
â”‚       â”œâ”€â”€ application.yml
â”‚       â””â”€â”€ db/migration/   # Flyway migrations
â””â”€â”€ test/
```

## ðŸ—ï¸ Architecture

This project follows Hexagonal Architecture (Ports & Adapters):

- **Domain**: Business logic and domain models
- **Application**: Use cases and application services
- **Infrastructure**: External adapters (database, APIs, etc.)
- **API**: REST controllers and DTOs

## ðŸ” Security

- JWT-based authentication
- Spring Security configuration
- Rate limiting
- Input validation

## ðŸ“ API Documentation

API documentation is available at `/api/swagger-ui.html` when running the application.

## ðŸ§ª Testing

```bash
# Run all tests
mvn test

# Run with coverage
mvn clean test jacoco:report
```

## ðŸ“¦ Deployment

The application is containerized and can be deployed to Azure Container Apps.

## ðŸ“„ License

Proprietary - Nooma AI Platform
'@

$readmeContent | Out-File -FilePath "README.md" -Encoding UTF8

Write-Host "âœ… Nooma AI Backend initialized successfully!" -ForegroundColor Green
Write-Host "ðŸ“ Project created at: $ProjectPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. cd $ProjectPath" -ForegroundColor White
Write-Host "2. mvn clean install" -ForegroundColor White
Write-Host "3. docker-compose up -d postgres redis" -ForegroundColor White
Write-Host "4. mvn spring-boot:run" -ForegroundColor White

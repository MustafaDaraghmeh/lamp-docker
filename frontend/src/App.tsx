import React, { useState, useEffect } from 'react'
import './App.css'

interface ServiceStatus {
  name: string
  status: 'running' | 'checking' | 'failed'
  port?: number
  url?: string
}

function App() {
  const [services, setServices] = useState<ServiceStatus[]>([
    { name: 'Web Server (PHP)', status: 'checking', port: 8080, url: 'http://localhost:8080' },
    { name: 'phpMyAdmin', status: 'checking', port: 8081, url: 'http://localhost:8081' },
    { name: 'pgAdmin', status: 'checking', port: 5050, url: 'http://localhost:5050' },
    { name: 'MongoDB Express', status: 'checking', port: 8082, url: 'http://localhost:8082' },
    { name: 'MailHog', status: 'checking', port: 8025, url: 'http://localhost:8025' },
  ])

  useEffect(() => {
    const checkServices = async () => {
      const updatedServices = await Promise.all(
        services.map(async (service) => {
          try {
            const response = await fetch(service.url || '', { mode: 'no-cors' })
            return { ...service, status: 'running' as const }
          } catch {
            return { ...service, status: 'failed' as const }
          }
        })
      )
      setServices(updatedServices)
    }

    const interval = setInterval(checkServices, 5000)
    checkServices()

    return () => clearInterval(interval)
  }, [])

  return (
    <div className="container">
      <h1>🚀 Web Development Lab - Service Status</h1>
      
      <section className="databases">
        <h2>📊 Databases</h2>
        <div className="grid">
          <div className="card">
            <h3>MySQL</h3>
            <p>Port: 3306</p>
            <code>mysql_db:3306</code>
            <p className="credentials">User: app_user | Pass: app_pass</p>
          </div>
          <div className="card">
            <h3>MariaDB</h3>
            <p>Port: 3307</p>
            <code>mariadb:3306</code>
            <p className="credentials">User: maria_user | Pass: maria_pass</p>
          </div>
          <div className="card">
            <h3>PostgreSQL</h3>
            <p>Port: 5432</p>
            <code>postgres:5432</code>
            <p className="credentials">User: postgres_user | Pass: postgres_pass</p>
          </div>
          <div className="card">
            <h3>MongoDB</h3>
            <p>Port: 27017</p>
            <code>mongodb:27017</code>
            <p className="credentials">User: root | Pass: rootpass</p>
          </div>
        </div>
      </section>

      <section className="tools">
        <h2>🛠️ Development Tools & UIs</h2>
        <div className="services-list">
          {services.map((service) => (
            <div key={service.name} className={`service-item ${service.status}`}>
              <span className={`status-badge ${service.status}`}>
                {service.status === 'running' ? '✓' : service.status === 'checking' ? '⟳' : '✗'}
              </span>
              <div className="service-info">
                <strong>{service.name}</strong>
                <small>Port: {service.port}</small>
              </div>
              <a href={service.url} target="_blank" rel="noopener noreferrer" className="service-link">
                Open →
              </a>
            </div>
          ))}
        </div>
      </section>

      <section className="tech-stack">
        <h2>🎯 Tech Stack</h2>
        <div className="grid">
          <div className="tech-item">
            <h4>Backend</h4>
            <ul>
              <li>PHP 8.2 + Apache</li>
              <li>Composer</li>
              <li>Xdebug</li>
            </ul>
          </div>
          <div className="tech-item">
            <h4>Frontend</h4>
            <ul>
              <li>React 18</li>
              <li>TypeScript</li>
              <li>Vite</li>
              <li>Bootstrap</li>
            </ul>
          </div>
          <div className="tech-item">
            <h4>Databases</h4>
            <ul>
              <li>MySQL 8.0</li>
              <li>MariaDB 10.11</li>
              <li>PostgreSQL 15</li>
              <li>MongoDB 6.0</li>
            </ul>
          </div>
          <div className="tech-item">
            <h4>Tools</h4>
            <ul>
              <li>phpMyAdmin</li>
              <li>pgAdmin</li>
              <li>MongoDB Express</li>
              <li>MailHog</li>
            </ul>
          </div>
        </div>
      </section>

      <section className="quick-commands">
        <h2>⚡ Quick Commands</h2>
        <pre>{`
# Start all services
docker compose up -d

# View logs
docker compose logs -f [service-name]

# Run PHP commands
docker compose exec workspace bash

# Run npm commands
docker compose exec frontend npm install

# Stop all services
docker compose down
        `}</pre>
      </section>
    </div>
  )
}

export default App

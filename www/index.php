<?php
// Web Development Lab - Main Dashboard
header('Content-Type: text/html; charset=utf-8');
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Web Dev Lab - PHP Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 900px;
            width: 100%;
            padding: 3rem;
        }

        h1 {
            color: #333;
            margin-bottom: 0.5rem;
            text-align: center;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 2rem;
        }

        .status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .status-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 8px;
            text-align: center;
        }

        .status-card h3 {
            margin-bottom: 0.5rem;
        }

        .status-card p {
            opacity: 0.9;
            font-size: 0.9rem;
        }

        .info-section {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-top: 1.5rem;
        }

        .info-section h3 {
            color: #667eea;
            margin-bottom: 1rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .info-item {
            background: white;
            padding: 1rem;
            border-radius: 4px;
            border-left: 4px solid #667eea;
        }

        .info-item strong {
            color: #667eea;
            display: block;
            margin-bottom: 0.25rem;
        }

        .info-item code {
            background: #f0f0f0;
            padding: 0.25rem 0.5rem;
            border-radius: 3px;
            color: #d63384;
            font-size: 0.9rem;
        }

        .php-info {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-top: 1.5rem;
            font-family: monospace;
            font-size: 0.9rem;
        }

        .php-info h3 {
            color: #667eea;
            margin-bottom: 1rem;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI';
        }

        .php-info-row {
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 1rem;
            padding: 0.5rem 0;
            border-bottom: 1px solid #ddd;
        }

        .php-info-row:last-child {
            border-bottom: none;
        }

        .label {
            color: #667eea;
            font-weight: bold;
        }

        .divider {
            height: 2px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            margin: 2rem 0;
        }

        a {
            color: #667eea;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
            }

            .php-info-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✅ PHP Backend is Running!</h1>
        <p class="subtitle">Web Development Lab - PHP Server Status</p>

        <div class="status-grid">
            <div class="status-card">
                <h3>🚀 Server</h3>
                <p>PHP 8.2 with Apache</p>
            </div>
            <div class="status-card">
                <h3>📦 Version</h3>
                <p><?php echo phpversion(); ?></p>
            </div>
            <div class="status-card">
                <h3>💾 Memory</h3>
                <p><?php echo ini_get('memory_limit'); ?></p>
            </div>
        </div>

        <div class="divider"></div>

        <div class="info-section">
            <h3>📊 Database Connections</h3>
            <div class="info-grid">
                <div class="info-item">
                    <strong>MySQL</strong>
                    <code>mysql_db:3306</code>
                    <small>User: app_user</small>
                </div>
                <div class="info-item">
                    <strong>MariaDB</strong>
                    <code>mariadb:3306</code>
                    <small>User: maria_user</small>
                </div>
                <div class="info-item">
                    <strong>PostgreSQL</strong>
                    <code>postgres:5432</code>
                    <small>User: postgres_user</small>
                </div>
                <div class="info-item">
                    <strong>MongoDB</strong>
                    <code>mongodb:27017</code>
                    <small>User: root</small>
                </div>
            </div>
        </div>

        <div class="info-section">
            <h3>🌐 Available Services</h3>
            <div class="info-grid">
                <div class="info-item">
                    <strong>phpMyAdmin</strong>
                    <a href="http://localhost:8081" target="_blank">Port 8081 →</a>
                </div>
                <div class="info-item">
                    <strong>pgAdmin</strong>
                    <a href="http://localhost:5050" target="_blank">Port 5050 →</a>
                </div>
                <div class="info-item">
                    <strong>MongoDB Express</strong>
                    <a href="http://localhost:8082" target="_blank">Port 8082 →</a>
                </div>
                <div class="info-item">
                    <strong>MailHog</strong>
                    <a href="http://localhost:8025" target="_blank">Port 8025 →</a>
                </div>
                <div class="info-item">
                    <strong>React Frontend</strong>
                    <a href="http://localhost:5173" target="_blank">Port 5173 →</a>
                </div>
                <div class="info-item">
                    <strong>Dashboard</strong>
                    <a href="/dashboard.html" target="_blank">View Dashboard →</a>
                </div>
            </div>
        </div>

        <div class="php-info">
            <h3>ℹ️ PHP Extensions Available</h3>
            <?php
            $extensions = ['PDO', 'mysqli', 'xdebug', 'zip'];
            foreach ($extensions as $ext) {
                $status = extension_loaded($ext) ? '✓ Enabled' : '✗ Disabled';
                $color = extension_loaded($ext) ? '#4ade80' : '#ef4444';
                echo "<div class='php-info-row'>";
                echo "<span class='label'>$ext:</span>";
                echo "<span style='color: $color;'>$status</span>";
                echo "</div>";
            }
            ?>
        </div>

        <div class="divider"></div>

        <div class="info-section" style="background: #fffbeb; border-left: 4px solid #f59e0b;">
            <h3 style="color: #d97706;">📝 Next Steps</h3>
            <ul style="margin: 0 0 0 1.5rem; color: #666;">
                <li>Create your PHP files in the <code>www/</code> directory</li>
                <li>Use the React frontend at port 5173 for modern JS development</li>
                <li>Connect to databases using the service names above</li>
                <li>Check <code>docker compose logs</code> for debugging</li>
                <li>Run <code>bash health-check.sh</code> to verify all services</li>
            </ul>
        </div>
    </div>
</body>
</html>
<?php
// Database connection
$servername = "mysql_db";
$username = "app_user";
$password = "app_pass";
$database = "app_db";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Create table if it doesn't exist
$createTable = "
CREATE TABLE IF NOT EXISTS students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
";
$conn->query($createTable);

// Insert sample data if table is empty
$checkData = $conn->query("SELECT COUNT(*) as count FROM students");
$row = $checkData->fetch_assoc();
if ($row['count'] == 0) {
    $conn->query("INSERT INTO students (name) VALUES ('Alice_01'), ('Bob_01')");
}

class StudentManager {
    private $conn;
    
    public function __construct($conn) {
        $this->conn = $conn;
    }
    
    // Add student
    public function addStudent($name) {
        $sql = "INSERT INTO students (name) VALUES (?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("s", $name);
        return $stmt->execute();
    }
    
    // Get all students
    public function getAllStudents() {
        $sql = "SELECT * FROM students ORDER BY created_at DESC";
        $result = $this->conn->query($sql);
        return $result ? $result->fetch_all(MYSQLI_ASSOC) : [];
    }
    
    // Get student by ID
    public function getStudentById($id) {
        $sql = "SELECT * FROM students WHERE id=?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        return $stmt->get_result()->fetch_assoc();
    }
    
    // Search by name
    public function searchByName($keyword) {
        $keyword = "%" . $this->conn->real_escape_string($keyword) . "%";
        $sql = "SELECT * FROM students WHERE name LIKE ? ORDER BY created_at DESC";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("s", $keyword);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }
    
    // Update student name
    public function updateStudent($id, $name) {
        $sql = "UPDATE students SET name=? WHERE id=?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("si", $name, $id);
        return $stmt->execute();
    }
    
    // Delete student
    public function deleteStudent($id) {
        $sql = "DELETE FROM students WHERE id=?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}

// Usage
$manager = new StudentManager($conn);

// Example: Add student
$manager->addStudent("Charlie");

// Example: Get all students
$students = $manager->getAllStudents();
echo json_encode($students);

// Example: Search
$results = $manager->searchByName("Alice");

// Example: Get by ID
$student = $manager->getStudentById(1);
echo json_encode($student);

// Example: Update
$manager->updateStudent(1, "Alice Updated");

// Example: Delete
$manager->deleteStudent(2);

$conn->close();
?>
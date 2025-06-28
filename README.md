# 🌿 Leave Management System

A full-featured **Java-based web application** for managing employee leave requests. Built using **JSP**, **Servlets**, **MySQL**, and **CSS/JS**, this system supports **role-based login**, **email-based password recovery**, and **leave request management** with a clean and user-friendly interface.

---

## 🚀 Features

### 👨‍💼 Admin:
- View all leave requests
- Approve or reject employee requests
- Sends approval/rejection emails automatically
- Admin dashboard with role label

### 👨‍🔧 Employee/User:
- Register/Login securely
- Apply for leave
- View leave status and history
- Reset password via email link

### ✉️ Email Integration:
- Forgot password → email reset link
- Leave status update via email (approved/rejected)

### 🎨 UI/UX:
- Fully styled using CSS + minimal JavaScript
- Font Awesome Icons used
- Responsive layout with centered forms
- UI designed with assistance from [v0.dev](https://v0.dev)

---

## 🧩 Tech Stack

| Layer     | Tech                            |
|-----------|---------------------------------|
| Frontend  | HTML, CSS, JSP, JavaScript      |
| Backend   | Java (Servlets), Jakarta EE     |
| Database  | MySQL                           |
| Email     | JavaMail API                    |
| IDE       | Eclipse                         |
| Server    | Apache Tomcat 10                |

---

## 🗂 Project Structure

LeaveManagementSystem/
│
├── src/
│ └── main/
│ └── java/
│ └── com/
│ └── leaveapp/
│ ├── AdminActionServlet.java
│ ├── AdminLeaveRequestsServlet.java
│ ├── DBConnection.java
│ ├── EmailUtil.java
│ ├── ForgotPasswordServlet.java
│ ├── LeaveRequest.java
│ ├── LeaveRequestServlet.java
│ ├── LeaveStatusServlet.java
│ ├── LoginServlet.java
│ ├── LogoutServlet.java
│ ├── RegisterServlet.java
│ └── ResetPasswordServlet.java
│
├── src/
│ └── main/
│ └── webapp/
│ └── jsp/
│ ├── adminDashboard.jsp
│ ├── adminLeaveRequests.jsp
│ ├── forgot-password.jsp
│ ├── forgot-password-success.jsp
│ ├── leaveRequest.jsp
│ ├── leaveStatus.jsp
│ ├── login.jsp
│ ├── logout.jsp
│ ├── register.jsp
│ ├── reset-password.jsp
│ ├── reset-password-error.jsp
│ ├── reset-password-success.jsp
│ └── userDashboard.jsp
│
├── META-INF/
├── WEB-INF/
│ └── web.xml


---

## 🧪 Database Schema (MySQL)

### `users` Table

```sql
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL,
  password VARCHAR(256) NOT NULL,
  role VARCHAR(10) NOT NULL,
  email VARCHAR(150) NOT NULL
);

### `leave_requests` Table

CREATE TABLE leave_requests (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100),
  leave_type VARCHAR(50),
  from_date DATE,
  to_date DATE,
  reason TEXT,
  status VARCHAR(20)
);

### `password_reset_tokens` Table

CREATE TABLE password_reset_tokens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    expires_at TIMESTAMP NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_token (token),
    INDEX idx_email (email),
    INDEX idx_expires (expires_at)
);


🧑‍💻 How to Run
1. Clone Repo
git clone https://github.com/your-username/LeaveManagementSystem.git
cd LeaveManagementSystem

2. Open in Eclipse
    Import as Dynamic Web Project
    Configure Apache Tomcat 10
    Add MySQL JDBC connector to the lib/ folder

3. Configure DB
    Create database leave_management
    Run above schema SQL to create tables
    Update your DB credentials in DBConnection.java:
    String url = "jdbc:mysql://localhost:3306/leave_management";
    String user = "root";
    String password = "your_password";

4. Configure Mail
In EmailUtil.java, set:
final String fromEmail = "your_email@gmail.com";
final String password = "your_email_password";

Enable Less Secure App Access or use App Password if 2FA is on

📷 Screenshots

Register page:
![image](https://github.com/user-attachments/assets/c18b54c6-04da-402d-a1ec-3a4e5ca91c3d)

Login page:
![image](https://github.com/user-attachments/assets/e438e6a7-71df-4393-9ccc-6a896c06246c)

Admin dashboard:
![image](https://github.com/user-attachments/assets/94bed449-6d3b-4d69-8d4c-2d8e1c3ef37d)
![image](https://github.com/user-attachments/assets/dde04683-2ce0-46d5-a242-74d7733f104c)

User dashboard:
![image](https://github.com/user-attachments/assets/19f1592d-e3c9-46b3-8e38-8044f32c3f87)
![image](https://github.com/user-attachments/assets/7302b92b-f32d-4195-939b-495b768e7527)


💡 Future Enhancements
    Leave request history export (PDF/CSV)
    Profile management
    Admin analytics dashboard


📄 License
This project is licensed under the MIT License.

# Pathology Lab Management System

A comprehensive, role-based pathology lab management portal designed to streamline diagnostic reporting, patient appointment booking, and lab administration. Built with **Java (Jakarta EE)**, **MySQL**, and modern frontend aesthetics, it ensures 24/7 access to digital reports, 99.9% uptime, and lightning-fast report delivery.

---

## 🚀 Key Features

* **Role-Based Access Control:** Dedicated, secure portals for **Admin**, **Staff**, and **Patients**.
* **Instant Digital Reports:** Upload reports in seconds, and patients can download PDFs securely at any time.
* **Smart Appointment Booking:** Book tests seamlessly online or manually add walk-in patients via the staff console.
* **Priority Queues:** Manage urgent tests vs. normal tests effectively.
* **Real-time Status Tracking:** Track reports from *Pending* to *Delivered*.
* **Secure & Responsive:** BCrypt password hashing and responsive web UI for mobile and desktop.

---

## 🛠️ Technology Stack

* **Backend:** Java 21, Jakarta Servlet API 6.0, Maven
* **Database:** MySQL 8.3 (JDBC)
* **Security:** BCrypt (Password Hashing)
* **Utilities:** Jakarta Mail (Email Notifications), Lombok
* **Frontend:** HTML5, CSS3, JavaScript (Vanilla), JSP

---

## 📊 Database Schema Architecture

The relational database (`MySQL`) is structured to maintain data integrity across users, patients, and their diagnostic records.

### 1. Users Table
Manages authentication and role assignment (`ADMIN`, `USER`, `STAFF`).
![Users Table](screenshots/db_users.png)

### 2. Patients Table
Stores patient demographic data. Linked to the `users` table.
![Patients Table](screenshots/db_patients.png)

### 3. Reports Table
Tracks pathology test results, file paths, and current status (`Pending`, `Completed`, `Delivered`).
![Reports Table](screenshots/db_reports.png)

### 4. Appointments Table
Handles online and walk-in bookings, locations, and time slots. Statuses include `Booked`, `Confirmed`, `Completed`, and `Cancelled`.
![Appointments Table](screenshots/db_appointments.png)

### 5. Feedback Table
Captures user feedback and ratings.
![Feedback Table](screenshots/db_feedback.png)

---

## 📸 System Portals & Walkthrough

### 1. Landing & Authentication
A beautiful entry point letting users choose their respective workspace, followed by a clean authentication interface.
![Landing Page](screenshots/portal_landing.png)
![Sign In](screenshots/portal_signin.png)

### 2. Admin Command Center
Provides a bird's-eye view of lab operations. Admins can view analytics, manage patient records, and oversee all uploaded reports.
![Admin Dashboard](screenshots/admin_dashboard.png)
![Manage Patients](screenshots/admin_manage_patients.png)
![All Reports](screenshots/admin_all_reports.png)
![Appointments Overview](screenshots/admin_appointments_overview.png)

### 3. Staff Operations Console
Optimized for speed, allowing lab technicians to quickly book walk-in appointments, manage queues, and upload digital reports (PDF/Images).
![Staff Dashboard](screenshots/staff_dashboard.png)
![Book Appointment](screenshots/staff_book_appointment.png)
![Upload Report](screenshots/staff_upload_report.png)

### 4. Patient Self-Service Portal
A clean, reassuring interface for patients to view test timelines, book appointments for themselves or family members, and download their finalized PDF reports.
![Patient Dashboard](screenshots/patient_dashboard.png)
![Manage Appointments](screenshots/patient_manage_appointments.png)
![Appointment Details - 1](screenshots/patient_appointment_details_1.png)
![Appointment Details - 2](screenshots/patient_appointment_details_2.png)
![Patient All Reports](screenshots/patient_all_reports.png)

---

## ⚙️ Setup & Installation

1. **Clone the repository.**
2. **Database Setup:** 
   * Import the MySQL schema into a database named (e.g., `pathology_lab`).
   * Update database credentials in the application's config properties.
3. **Build the project:** 
   * Run `mvn clean install` to generate the `.war` file.
4. **Deploy:** 
   * Deploy the generated `Pathlogy_Lab.war` to a Servlet container (e.g., Apache Tomcat 10+).
5. **Access:**
   * Open your browser and navigate to `http://localhost:8080/Pathlogy_Lab`.

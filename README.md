# ======================================
# Project Management Customer (Flutter)
# ======================================

project:
  name: "Project Management Customer"
  platform: "Flutter"
  programming_language: "Dart"
  ui_language: "Arabic"

# --------------------------------------
# Description
# --------------------------------------
description: >
  تطبيق لإدارة العملاء والديون مبني باستخدام Flutter.
  يساعد أصحاب الأعمال على تتبع العملاء، تسجيل الديون،
  متابعة التحصيل، ومعرفة المبالغ المستحقة من خلال
  واجهة عربية بسيطة وسهلة الاستخدام.

  التطبيق يعمل حاليًا ببيانات محلية (بدون قاعدة بيانات)
  ومناسب كمشروع تعليمي أو مشروع تخرج.

# --------------------------------------
# Features
# --------------------------------------
features:
  authentication:
    - "شاشة تسجيل دخول"
  customer_management:
    - "إضافة عميل"
    - "تعديل بيانات العميل"
    - "حذف عميل"
  debt_management:
    - "إضافة دين"
    - "تحديد تاريخ الاستحقاق"
    - "عرض حالة الدين (نشط / متأخر / مسدد)"
  collection:
    - "تحصيل الديون"
    - "تحديث حالة الدين تلقائيًا"
  dashboard:
    - "إجمالي الديون"
    - "المبلغ المحصل"
    - "المبلغ المتبقي"
  navigation:
    - "قائمة جانبية Drawer"
  localization:
    - "واجهة عربية بالكامل"

# --------------------------------------
# Technologies
# --------------------------------------
technologies:
  framework: "Flutter"
  language: "Dart"
  design: "Material Design"
  state_management: "setState"

# --------------------------------------
# Project Structure
# --------------------------------------
project_structure:
  lib:
    main.dart: "تشغيل التطبيق + تسجيل الدخول"
    home.dart: "لوحة التحكم الرئيسية"
    drawer.dart: "القائمة الجانبية"
    customers.dart: "إدارة العملاء"
    customerAuditing.dart: "تفاصيل حساب العميل"
    addDebtPage.dart: "إضافة دين جديد"
    collectionPage.dart: "صفحة التحصيل (قيد التطوير)"

# --------------------------------------
# How to Run
# --------------------------------------
run_instructions:
  prerequisites:
    - "Flutter SDK مثبت"
    - "Android Studio أو VS Code"
  steps:
    - "flutter doctor"
    - "git clone https://github.com/USERNAME/project_mangment_customer.git"
    - "cd project_mangment_customer"
    - "flutter pub get"
    - "flutter run"

# --------------------------------------
# Login Credentials
# --------------------------------------
login_credentials:
  username: "amgad"
  password: "amgad"
  warning: "بيانات ثابتة للتجربة فقط"

# --------------------------------------
# Technical Notes
# --------------------------------------
technical_notes:
  data_storage:
    - "Local State باستخدام Lists"
    - "لا يوجد قاعدة بيانات"
  backend:
    status: "غير مستخدم حاليًا"
  future_database_options:
    - "SQLite"
    - "Firebase"
    - "REST API"

# --------------------------------------
# Screenshots
# --------------------------------------
## 📸 صور التطبيق
 📸 App Screenshots


<details>
<summary>Drawer</summary>
<img width="543" height="925" alt="settings_screenshot" src="https://i.postimg.cc/q73SJwd9/IMG-20260126-WA0006.jpg)](https://postimg.cc/v1G3XWTz)" />
</details>


</details>

<details>
<summary>Rebot</summary>
<img width="543" height="925" alt="settings_screenshot"
  src="https://i.postimg.cc/fLg98cVQ/IMG-20260126-WA0005.jpg)](https://postimg.cc/KkBjzg70" />
</details>

<details>
<summary>Setteings</summary>
<img width="543" height="925" alt="settings_screenshot"
  src="https://i.postimg.cc/vZq6zRDK/IMG-20260126-WA0004.jpg)](https://postimg.cc/JsXnr2N3" />
</details>

<details>
<summary>Add client</summary>
<img width="543" height="925" alt="settings_screenshot"
  src="https://i.postimg.cc/s2rbwL89/IMG-20260126-WA0003.jpg)](https://postimg.cc/68MHQMBy" />
</details>

<details>
<summary>Custemrs</summary>
<img width="543" height="925" alt="settings_screenshot"
  src="https://i.postimg.cc/FHVQ5m0Y/IMG-20260126-WA0002.jpg)](https://postimg.cc/rDsHxBnT" />
</details>

<details>
<summary>Login</summary>
<img width="543" height="925" alt="settings_screenshot"
  src="https://i.postimg.cc/CxBfmPDz/IMG-20260126-WA0011.jpg)](https://postimg.cc/ZWmRqLwS" />
</details>

<details>
<summary>Achievement</summary>
<img width="543" height="925" alt="settings_screenshot"
  src="https://i.postimg.cc/PxxHQcpM/IMG-20260126-WA0009.jpg)](https://postimg.cc/KKdCZ05K" />
</details>

<details>
<summary>Home</summary>
<img width="543" height="925" alt="settings_screenshot"
  src="https://i.postimg.cc/3xczHRdw/IMG-20260126-WA0007.jpg)](https://postimg.cc/87LZRTd8" />
</details>


# --------------------------------------
# Future Enhancements
# --------------------------------------
future_plans:
  - "ربط قاعدة بيانات حقيقية"
  - "تقارير مالية شهرية وسنوية"
  - "إشعارات تذكير بمواعيد الاستحقاق"
  - "تحسين تجربة المستخدم"

# --------------------------------------
# Developer
# --------------------------------------
developer:
  name: "امجد صادق"
  github: "https://github.com/USERNAME"

# --------------------------------------
# License
# --------------------------------------
license:
  type: "Open Source"
  usage: "تعليمي / تدريبي"

import 'package:flutter/material.dart';
import 'package:mainproject/admin/screens/adm_addpost_screen.dart';
import 'package:mainproject/admin/screens/message/adm_msg_screen.dart';
import 'package:mainproject/admin/screens/department/Accademy/accademy_screen.dart';
import 'package:mainproject/admin/screens/department/Accademy/timetable_screen.dart';
import 'package:mainproject/admin/screens/department/attendance/attdnce_date_screen.dart';
import 'package:mainproject/admin/screens/department/subjects/subdetails_screen.dart';
import 'package:mainproject/admin/screens/department/subjects/subjectadd_screen.dart';
import 'package:mainproject/admin/screens/department/subjects/subjectassign_screen.dart';
import 'package:mainproject/admin/screens/department/subjects/subjects_screen.dart';
import 'package:mainproject/admin/screens/lecture/lectureadd_screen.dart';
import 'package:mainproject/admin/screens/settings/chatroom/chat_screen.dart';
import 'package:mainproject/admin/screens/settings/chatroom/chatroom_screen.dart';
import 'package:mainproject/admin/screens/settings/editprofile_screen.dart';
import 'package:mainproject/admin/screens/settings/managepost_screen.dart';
import 'package:mainproject/admin/screens/settings/unamepassedit_screen.dart';
import 'package:mainproject/admin/screens/students/studentadd_screen.dart';
import 'package:mainproject/screens/login_screen.dart';
import 'package:mainproject/screens/reg_check.dart';
import 'package:mainproject/screens/register_screen.dart';
import 'package:mainproject/screens/splash_screen.dart';
import 'package:mainproject/student/screens/messenger.dart';
import 'package:mainproject/student/screens/stud_activities.dart';
import 'package:mainproject/student/screens/stud_department.dart';
import 'package:mainproject/student/screens/stud_rate.dart';
import 'package:mainproject/student/screens/stud_settings.dart';
import 'package:mainproject/student/student_dashboard.dart';
import 'package:mainproject/teacher/screens/messenger.dart';
import 'package:mainproject/teacher/screens/teach_settings.dart';

import 'admin/admn_dashboard.dart';
import 'admin/screens/department/attendance/attendance_screen.dart';
import 'admin/screens/department/dep_screen.dart';
import 'admin/screens/lecture/lecture_screen.dart';
import 'admin/screens/settings/settings_screen.dart';
import 'admin/screens/students/student_screen.dart';
import 'teacher/screens/teach_attendance.dart';
import 'teacher/screens/teach_rate.dart';
import 'teacher/screens/teach_utensils.dart';
import 'teacher/teacher_dashboard.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    ),
    debugShowCheckedModeBanner: false,
    home: const SplashScreen(),
    routes: {
      '/register': (context) => const MyRegister(),
      '/reg_check': (context) => const Reg_Check(),
      '/login': (context) => const MyLogin(),
      '/admndashboard': (context) => const admnHome(),
      '/admndep': (context) => const Dep_screen(),
      '/admndepaccademics': (context) => const accademy_screen(),
      '/admndeptimetable': (context) => const Timetable_Screen(),
      '/admndepattendance': (context) => const attendance_screen(),
      '/admndepattdncedate': (context) => const Attdnce_date(),
      '/admndepsubject': (context) => const Subject_screen(),
      '/admndepsubdetails': (context) => const Subject_details(),
      '/admndepsubadd': (context) => const Subject_Add(),
      '/admndepsubassign': (context) => const Subject_Assign(),
      '/admnlec': (context) => const lec_screen(),
      '/admnstud': (context) => const Stud_screen(),
      '/admnstudentadd': (context) => const StudentAdd(),
      '/admnlectureadd': (context) => const LectureAdd(),
      '/admnmessage': (context) => const Admin_message(),
      '/admnaddpost': (context) => const Admin_Add_Post(),
      '/admnsett': (context) => const Settings_screen(),
      '/admnsetteditprofile': (context) => const Edit_Profile(),
      '/admnsettpostmanage': (context) => const Manage_Post(),
      '/admnsettchatroom': (context) => const Chat_Room_admn(),
      '/admnsettchatbox': (context) => const Chat_Screen_admn(),
      '/admnsettunamepassedit': (context) => const Unamepass_Edit(),
      '/techdashboard': (context) => const teach_Home(),
      '/teachattend': (context) => const teach_attendance(),
      '/teachrate': (context) => const teach_Rate(),
      '/teachutens': (context) => const teach_Utensils(),
      '/teachsett': (context) => const teach_sett(),
      '/teachmessage': (context) => const teach_message(),
      '/studdashboard': (context) => const student_Dashboard(),
      '/studdepartment': (context) => const stud_Department(),
      '/studrate': (context) => const stud_Rate(),
      '/studactivities': (context) => const stud_activities(),
      '/studsett': (context) => const stud_Settings(),
      '/studmessage': (context) => const stud_Message(),
    },
  ));
}

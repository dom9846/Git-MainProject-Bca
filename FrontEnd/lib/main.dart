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
import 'package:mainproject/student/screens/message/student_msg_screen.dart';
import 'package:mainproject/student/screens/stud_addpost_screen.dart';
import 'package:mainproject/student/student_dashboard.dart';
import 'package:mainproject/teacher/screens/department/attendance/teachattendance_screen.dart';
import 'package:mainproject/teacher/screens/department/attendance/teachmarkattdnce_screen.dart';
import 'package:mainproject/teacher/screens/message/teachermsg_screen.dart';
import 'package:mainproject/teacher/screens/teachaddpostnew_screen.dart';

import 'admin/admn_dashboard.dart';
import 'admin/screens/department/attendance/attendance_screen.dart';
import 'admin/screens/department/dep_screen.dart';
import 'admin/screens/lecture/lecture_screen.dart';
import 'admin/screens/settings/settings_screen.dart';
import 'admin/screens/students/student_screen.dart';
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
      '/teachdashboard': (context) => const teach_Home(),
      '/teachmessage': (context) => const Teach_Message(),
      '/teachaddnewpost': (context) => const TeachAddNew_Post(),
      '/teachdepattdnce': (context) => const Attendance_yearScreen(),
      '/teachdepattdncemark': (context) => const MarkAttendance_Teacher(),
      '/studdashboard': (context) => const student_Dashboard(),
      '/studmessage': (context) => const Student_Message(),
      '/studaddnewpost': (context) => const Studaddnew_Post(),
    },
  ));
}

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
import 'package:mainproject/admin/screens/settings/chatroom/addnewchat_screen.dart';
import 'package:mainproject/admin/screens/message/chat_screen.dart';
import 'package:mainproject/admin/screens/settings/chatroom/chatroom_screen.dart';
import 'package:mainproject/admin/screens/settings/devoloperinfo_screen.dart';
import 'package:mainproject/admin/screens/settings/editprofile_screen.dart';
import 'package:mainproject/admin/screens/settings/managepost_screen.dart';
import 'package:mainproject/admin/screens/settings/unamepassedit_screen.dart';
import 'package:mainproject/admin/screens/students/studentadd_screen.dart';
import 'package:mainproject/screens/login_screen.dart';
import 'package:mainproject/screens/reg_check.dart';
import 'package:mainproject/screens/register_screen.dart';
import 'package:mainproject/screens/splash_screen.dart';
import 'package:mainproject/student/screens/department/accademy/assignedtask/allassignedtask_screen.dart';
import 'package:mainproject/student/screens/department/accademy/assignedtask/studtaskview_screen.dart';
import 'package:mainproject/student/screens/department/accademy/studentaccademy_screen.dart';
import 'package:mainproject/student/screens/department/accademy/teacherrating/rateteacherstud_screen.dart';
import 'package:mainproject/student/screens/department/accademy/teacherrating/ratingassignview_screen.dart';
import 'package:mainproject/student/screens/department/attendance/studattendance_screen.dart';
import 'package:mainproject/student/screens/department/attendance/studattndancestatus_screen.dart';
import 'package:mainproject/student/screens/department/internal/studinternal_screen.dart';
import 'package:mainproject/student/screens/department/internal/studinternalstatus_screen.dart';
import 'package:mainproject/student/screens/message/chat_stud.dart';
import 'package:mainproject/student/screens/message/chatscreen_stud.dart';
import 'package:mainproject/student/screens/message/student_msg_screen.dart';
import 'package:mainproject/student/screens/settings/studDevlperInfo_screen.dart';
import 'package:mainproject/student/screens/settings/studeditprofile_screen.dart';
import 'package:mainproject/student/screens/settings/studeditunamepass_screen.dart';
import 'package:mainproject/student/screens/settings/student_settings_screen.dart';
import 'package:mainproject/student/screens/stud_addpost_screen.dart';
import 'package:mainproject/student/screens/time_table_student_screen.dart';
import 'package:mainproject/student/student_dashboard.dart';
import 'package:mainproject/teacher/screens/department/accademy/accademy_screen.dart';
import 'package:mainproject/teacher/screens/department/accademy/timetable_screen.dart';
import 'package:mainproject/teacher/screens/department/attendance/teachattendance_screen.dart';
import 'package:mainproject/teacher/screens/department/attendance/teachmarkattdnce_screen.dart';
import 'package:mainproject/teacher/screens/department/subject/assignnewwork_screen.dart';
import 'package:mainproject/teacher/screens/department/subject/existingwork_screen.dart';
import 'package:mainproject/teacher/screens/department/subject/subjectworks_screen.dart';
import 'package:mainproject/teacher/screens/department/subject/teachsubjectlist_screen.dart';
import 'package:mainproject/teacher/screens/message/chatscreen_teach.dart';
import 'package:mainproject/teacher/screens/message/teachermsg_screen.dart';
import 'package:mainproject/teacher/screens/settings/teachdevolperinfo_screen.dart';
import 'package:mainproject/teacher/screens/settings/teacheditprofile_screen.dart';
import 'package:mainproject/teacher/screens/settings/teachsettings_screen.dart';
import 'package:mainproject/teacher/screens/settings/teachunamepassedit_screen.dart';
import 'package:mainproject/teacher/screens/student/internal/internal_screen.dart';
import 'package:mainproject/teacher/screens/student/internal/subjectwisestudentinternal_screen.dart';
import 'package:mainproject/teacher/screens/student/message_stud/studentmsg_screen.dart';
import 'package:mainproject/teacher/screens/student/message_stud/students_screen.dart';
import 'package:mainproject/teacher/screens/student/rating/rating_screen.dart';
import 'package:mainproject/teacher/screens/student/rating/subwisestudentrating_screen.dart';
import 'package:mainproject/teacher/screens/student/teacherstudent_screen.dart';
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
    home: const student_Dashboard(),
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
      '/admnsettaddchatroom': (context) => const addNew_chat(),
      '/admnchatbox': (context) => const Chat_Screen_admn(),
      '/admnsettunamepassedit': (context) => const Unamepass_Edit(),
      '/admnsettdevinfo': (context) => const Devoloper_Info(),
      '/teachdashboard': (context) => const teach_Home(),
      '/teachmessage': (context) => const Teach_Message(),
      '/teachchat': (context) => const chat_Teach(),
      '/teachaddnewpost': (context) => const TeachAddNew_Post(),
      '/teachdepattdnce': (context) => const Attendance_yearScreen(),
      '/teachdepattdncemark': (context) => const MarkAttendance_Teacher(),
      '/teachdepsublist': (context) => const TeachSubject_List(),
      '/teachdepsubworks': (context) => const SubjectWork_Screen(),
      '/teachdepexistwork': (context) => const ExistingSubjectWork_Screen(),
      '/teachdepnewwork': (context) => const AssignNew_Work(),
      '/teachdepaccademy': (context) => const Accademy_ScreenTeach(),
      '/teachdeptimetable': (context) => const TimeTable_Teach(),
      '/teachstudscreen': (context) => const TeachStud_screen(),
      '/teachstudsubwiseinternal': (context) =>
          const SubjectWise_StudentInternal(),
      '/teachstudsinternal': (context) => const Teach_InternalStudent(),
      '/teachstudsubwiserating': (context) => const Subjectwisestudent_raing(),
      '/teachstudsrating': (context) => const Studentrating_Teach(),
      '/teachstudmsgyearlist': (context) => const TeachStudentYearMsg_Screen(),
      '/teachstudmsglistofstud': (context) => const Teachstudlistyear_message(),
      '/teachsettings': (context) => const Teach_settings(),
      '/teachsetteditprof': (context) => const TeachEdit_Profile(),
      '/teachsetteditunamepass': (context) => const TeachUnamePass_Edit(),
      '/teachsettdevinfo': (context) => const TeachDevoloper_Info(),
      '/studdashboard': (context) => const student_Dashboard(),
      '/studmessage': (context) => const Student_Message(),
      '/studchats': (context) => const ChatScreen_Stud(),
      '/studaddnewpost': (context) => const Studaddnew_Post(),
      '/studdepattndance': (context) => const AttendanceHistory_Student(),
      '/studdepattndancestatus': (context) => const Studattendance_Status(),
      '/studdepinternal': (context) => const StudentInternal_Screen(),
      '/studdepinternalstatus': (context) => const StudentInternal_status(),
      '/studdepaccdemy': (context) => const StudentAccademy_Screen(),
      '/studdepaccdemytaskall': (context) => const AllAssigned_TaskStud(),
      '/studdepaccdemytaskview': (context) => const TaskView_semesterwise(),
      '/studdepaccdemyassignrate': (context) => const AssignedRate_Task(),
      '/studdepaccdemyrateform': (context) => const StudentRateTeach_Form(),
      '/studtimetablescreen': (context) => const StudentTimeTable_Screen(),
      '/studsettings': (context) => const StudentSettings_Screen(),
      '/studsetteditprof': (context) => const StudentEdit_Profile(),
      '/studsetteditunamepass': (context) => const StudentEdit_UnamePass(),
      '/studsettdevinfo': (context) => const StudentDevoloper_Info(),
    },
  ));
}

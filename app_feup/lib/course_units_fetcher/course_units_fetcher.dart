import 'package:uni/model/entities/course_unit_evaluation_component.dart';
import 'package:uni/model/entities/course_unit_sheet.dart';
import 'package:uni/model/entities/course_unit_teacher.dart';

import '../model/entities/course_unit.dart';

class CourseUnitsFetcher {
  List<CourseUnitSheet> getCourseUnitsSheets(List<CourseUnit> userUcs) {
    final _esofTeachers = [
      CourseUnitTeacher('Ademar Manuel Teixeira de Aguiar', true, '3'),
      CourseUnitTeacher('João Carlos Pascoal Faria', true, '3'),
      CourseUnitTeacher('André Monteiro de Oliveira Restivo', false, '4'),
      CourseUnitTeacher('Daniel Ribeiro de Pinho', false, '4'),
      CourseUnitTeacher('José Carlos Medeiros de Campos', false, '8'),
      CourseUnitTeacher('Bruno Miguel Carvalhido Lima', false, '4'),
      CourseUnitTeacher('André Sousa Lago', false, '4'),
      CourseUnitTeacher('João Carlos Pascoal Faria', false, '2'),
      CourseUnitTeacher('Hugo José Sereno Lopes Ferreira', false, '6'),
      CourseUnitTeacher('Ademar Manuel Teixeira de Aguiar', false, '4'),
      CourseUnitTeacher(
          'Filipe Alexandre Pais de Figueiredo Correia', false, '4'),
    ];
    final _esofComponents = [
      CourseUnitEvaluationComponent('Trabalho escrito', '25,00'),
      CourseUnitEvaluationComponent('Trabalho prático ou de projeto	', '30,00'),
      CourseUnitEvaluationComponent('Exame', '35,00'),
      CourseUnitEvaluationComponent('Participação presencial', '10,00'),
    ];
    final _courses = [
      CourseUnitSheet(
          'Software Engineering',
          'Familiarizar-se com os métodos de engenharia e gestão necessários ao desenvolvimento de sistemas de software complexos e/ou em larga escala, de forma economicamente eficaz e com elevada qualidade.',
          '''INTRODUÇÃO: desafios do desenvolvimento de software em larga escala; objetivos e âmbito da engenharia de software; história da engenharia de software.\nPROCESSO DE SOFTWARE: noção de processo de software; atividades do processo; modelos de processos; exemplos de processos (RUP, XP, Scrum, etc.).\nGESTÃO DE PROJETOS DE SOFTWARE: planeamento, monitorização e controlo de projeto; estimação de software; gestão ágil e gestão clássica de projetos.\nREQUISITOS DE SOFTWARE: conceito de requisito de software; tipos de requisitos; identificação, análise, especificação e validação de requisitos; modelação de requisitos com UML; prototipagem de interfaces.\nDESENHO DE SOFTWARE: desenho de arquitetura; modelação de arquitetura com UML; reutilização de software; desenho detalhado.\nCONSTRUÇÃO E EVOLUÇÂO DE SOFTWARE: ambientes de desenvolvimento; integração contínua; gestão de versões e alterações; desenvolvimento ágil com XP; evolução e manutenção de software.\nVERIFICAÇÃO E VALIDAÇÃO DE SOFTWARE: conceitos básicos; testes unitários, de integração, de sistema e de aceitação; revisões e inspeções de software; registo de defeitos; análise estática de código.''',
          _esofComponents,
          _esofTeachers,
          true),
      CourseUnitSheet(
          'Artificial Intelligence',
          'Solve problems with optimization and machine learning.',
          '',
          [],
          [],
          true),
      CourseUnitSheet('Parallel and Distributed Computing',
          'Build parallel and distributed systems.', '', [], [], false),
      CourseUnitSheet(
          'Compilers',
          'An holistic class on compiler assembling and analysis.',
          '',
          [],
          [],
          true),
      CourseUnitSheet(
          'Capstone Project', 'An aggregation project.', '', [], [], false)
    ];
    return _courses;
  }
}

import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni/model/entities/course_units/course_unit_materials.dart';
import 'package:uni/model/entities/session.dart';
import 'package:uni/view/Widgets/course_units/course_unit_generic_card.dart';
import 'package:uni/view/Widgets/toast_message.dart';

import '../../../controller/networking/network_router.dart';

class CourseUnitMaterialCard extends CourseUnitGenericCard {
  final double padding = 12.0;
  final CourseUnitMaterials courseUnit;
  final Session session;

  CourseUnitMaterialCard(this.courseUnit, this.session);

  @override
  Widget buildCardContent(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          textColor: Theme.of(context).colorScheme.secondary,
          iconColor: Theme.of(context).colorScheme.secondary,
          childrenPadding:
              EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
          title: Text(
            this.courseUnit.courseName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          children: [
            (courseUnit.zipUrl.isEmpty)
                ? ListTile(
                    title: Text(
                    'Sem material disponível',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ))
                : ListTile(
                    dense: true,
                    title: Text(
                      'Transferir ficheiro ZIP',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    trailing: GestureDetector(
                        child: Icon(
                            IconData(0xf0509, fontFamily: 'MaterialIcons'),
                            color: Theme.of(context).colorScheme.secondary)),
                    onTap: () => _downloadFile(context),
                  )
          ],
        ));
  }

  void _downloadFile(BuildContext context) async {
    try {
      final String path = await FilesystemPicker.open(
        title: 'Escolher Pasta',
        context: context,
        rootDirectory:
            Directory((await ExternalPath.getExternalStorageDirectories())[0]),
        fsType: FilesystemType.folder,
        pickText: 'Guardar ZIP nesta pasta',
        folderIconColor: Theme.of(context).colorScheme.secondary,
        requestPermission: () async =>
            await Permission.storage.request().isGranted,
      );
      ToastMessage.display(context, 'A transferir...');
      final Response response =
          await NetworkRouter.getWithCookies(courseUnit.zipUrl, {}, session);
      if (await Permission.storage.request().isGranted) {
        final filteredCourseName =
            courseUnit.courseName.replaceAll(RegExp('[^A-Za-z0-9]'), '');
        final File file =
            File('$path/materiais_' + filteredCourseName + '.zip');
        await file.writeAsBytes(response.bodyBytes);
        ToastMessage.display(context, 'Transferência concluída');
      } else {
        ToastMessage.display(context, 'Permissão não concedida! Tente de novo');
      }
    } catch (e) {
      ToastMessage.display(
          context, 'Impossível transferir o ficheiro. Tente de novo');
      Logger().e(e.toString());
    }
  }
}

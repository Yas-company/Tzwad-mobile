import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../service/language_service.dart';
import '../../service/ticket_chat_service.dart';
import '../../view/utils/image_view.dart';
import '../../view/utils/constant_name.dart';
import 'package:provider/provider.dart';

import '../utils/constant_styles.dart';
import '../utils/text_themes.dart';

class TicketChat extends StatelessWidget {
  String title;
  final id;
  TicketChat(this.title, this.id, {Key? key}) : super(key: key);
  Key textFieldKey = const Key('key');
  final TextEditingController _controller = TextEditingController();

  Future<void> imageSelector(
    BuildContext context,
  ) async {
    try {
      FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'zip', 'png', 'jpeg'],
      );
      Provider.of<TicketChatService>(context, listen: false)
          .setPickedImage(File(file!.files.single.path as String));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    return Consumer<TicketChatService>(builder: (context, tcService, child) {
      return WillPopScope(
        onWillPop: () async {
          tcService.clearAllMessages();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 1,
            foregroundColor: cc.blackColor,
            centerTitle: true,
            title: RichText(
              softWrap: true,
              text: TextSpan(
                  text: '#${id}',
                  style: TextStyle(
                      color: cc.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                  children: [
                    TextSpan(
                        text: ' $title',
                        style: TextStyle(color: cc.blackColor)),
                  ]),
            ),
            leading: GestureDetector(
              onTap: () {
                tcService.clearAllMessages();
                Navigator.of(context).pop();
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform(
                      transform:
                          Provider.of<LanguageService>(context, listen: false)
                                  .rtl
                              ? Matrix4.rotationY(pi)
                              : Matrix4.rotationY(0),
                      child: SvgPicture.asset(
                        'assets/images/icons/back_button.svg',
                        color: cc.blackColor,
                        height: 25,
                      ),
                    ),
                  ]),
            ),
          ),
          body: tcService.ticketDetails == null
              ? loadingProgressBar()
              : Consumer<TicketChatService>(
                  builder: (context, tcService, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: messageListView(tcService),
                      ),
                      SizedBox(
                        height: screenHight / 7,
                        // margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            maxLines: 4,
                            controller: _controller,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: asProvider.getString('Write message'),
                              hintStyle:
                                  TextStyle(color: cc.greyHint, fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: cc.greyBorder2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: cc.greyBorder2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: cc.greyBorder2),
                              ),
                            ),
                            onChanged: (value) {
                              tcService.setMessage(value);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              asProvider.getString('File'),
                              style: TextStyle(
                                  color: cc.greyHint,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                imageSelector(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: cc.greyBorder2)),
                                child: Text(
                                  asProvider.getString('Choose file'),
                                  style: TextStyle(color: cc.greyHint),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: screenWidth / 3,
                              child: Text(
                                tcService.pickedImage == null
                                    ? asProvider.getString('No file chosen')
                                    : tcService.pickedImage!.path
                                        .split('/')
                                        .last,
                                style: TextThemeConstrants.greyHint13Eclipse,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 1.3,
                              child: Checkbox(

                                  // splashRadius: 30,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  side: BorderSide(
                                    width: 1,
                                    color: cc.greyBorder,
                                  ),
                                  activeColor: cc.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(
                                        width: 1,
                                        color: cc.greyBorder,
                                      )),
                                  value: tcService.notifyViaMail,
                                  onChanged: (value) {
                                    tcService.toggleNotifyViaMail(value);
                                  }),
                            ),
                            const SizedBox(width: 5),
                            RichText(
                              softWrap: true,
                              text: TextSpan(
                                text: asProvider.getString('Notify via mail'),
                                style:
                                    TextStyle(color: cc.greyHint, fontSize: 13
                                        // fontWeight: FontWeight.w600,
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Stack(
                          children: [
                            customContainerButton(
                              tcService.isLoading
                                  ? ''
                                  : asProvider.getString('Send'),
                              double.infinity,
                              tcService.message == ''
                                  ? () {}
                                  : () async {
                                      tcService.setIsLoading(true);
                                      FocusScope.of(context).unfocus();
                                      await tcService
                                          .sendMessage(
                                              tcService.ticketDetails!.id)
                                          .then((value) {
                                        if (value != null) {
                                          snackBar(context, value,
                                              backgroundColor: cc.orange);
                                          return;
                                        }
                                        _controller.clear();
                                      }).onError((error, stackTrace) =>
                                              snackBar(
                                                  context,
                                                  asProvider.getString(
                                                      'Connection failed'),
                                                  backgroundColor: cc.orange));
                                      tcService.setIsLoading(false);
                                    },
                              color: tcService.message == ''
                                  ? cc.greyDots
                                  : cc.primaryColor,
                            ),
                            if (tcService.isLoading)
                              SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Center(
                                      child: loadingProgressBar(
                                          size: 30, color: cc.pureWhite)))
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  );
                }),
        ),
      );
    });
  }

  Widget messageListView(TicketChatService tcService) {
    if (tcService.noMessage) {
      return Center(
        child: Text(
          asProvider.getString('No Message has been found!'),
          style: TextStyle(color: cc.greyHint),
        ),
      );
    } else {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          reverse: true,
          itemCount: tcService.messagesList.length,
          itemBuilder: ((context, index) {
            final element = tcService.messagesList[index];
            final usersMessage = element.type != 'admin';
            return SizedBox(
              width: screenWidth / 1.7,
              child: Column(
                crossAxisAlignment: usersMessage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: usersMessage
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                          // width: screenWidth / 1.7,
                          constraints:
                              BoxConstraints(maxWidth: screenWidth / 1.7),
                          // alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Provider.of<LanguageService>(context,
                                          listen: false)
                                      .rtl
                                  ? (usersMessage
                                      ? Radius.zero
                                      : const Radius.circular(20))
                                  : (usersMessage
                                      ? const Radius.circular(20)
                                      : Radius.zero),
                              bottomRight: Provider.of<LanguageService>(context,
                                          listen: false)
                                      .rtl
                                  ? (usersMessage
                                      ? Radius.circular(20)
                                      : Radius.zero)
                                  : (usersMessage
                                      ? Radius.zero
                                      : const Radius.circular(20)),
                            ),
                            color: usersMessage
                                ? cc.primaryColor
                                : const Color(0xffEFEFEF),
                          ),
                          child: Text(
                            tcService.messagesList[index].message,
                            style: usersMessage
                                ? TextStyle(color: cc.pureWhite)
                                : null,
                          )),
                      // ),
                    ],
                  ),
                  if (tcService.messagesList[index].attachment != null)
                    const SizedBox(height: 5),
                  if (tcService.messagesList[index].attachment != null)
                    showFile(
                        context,
                        tcService.messagesList[index].attachment,
                        tcService.messagesList[index].id,
                        usersMessage
                            ? (Provider.of<LanguageService>(context,
                                        listen: false)
                                    .rtl
                                ? Alignment.centerLeft
                                : Alignment.centerRight)
                            : (Provider.of<LanguageService>(context,
                                        listen: false)
                                    .rtl
                                ? Alignment.centerRight
                                : Alignment.centerLeft))
                ],
              ),
            );
          }));
    }
  }

  Widget showFile(
      BuildContext context, String url, int id, AlignmentGeometry alignment) {
    initiateDeviceSize(context);
    if (url.contains('.zip')) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: 50,
        child: SvgPicture.asset('assets/images/icons/zip_icon.svg'),
      );
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ImageView(url, id: id),
          ),
        );
      },
      child: Hero(
        tag: id,
        child: Container(
          height: 200,
          // width: screenWidth / 1.5,
          alignment: alignment,
          constraints: BoxConstraints(
            maxWidth: screenWidth / 1.5,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Image.network(
            url,
            alignment: alignment,
            loadingBuilder: (context, child, loding) {
              if (loding == null) {
                return child;
              }
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: alignment,
                        image: AssetImage(
                          'assets/images/product_skelleton.png',
                        ),
                        opacity: .4)),
              );
            },
            // imageUrl: url,
            errorBuilder: (context, str, some) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: alignment,
                        image:
                            AssetImage('assets/images/product_skelleton.png'),
                        opacity: .4)),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../service/language_service.dart';
import 'ticket_chat.dart';
import '../utils/constant_name.dart';
import '../../service/ticket_service.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_styles.dart';
import '../../service/ticket_chat_service.dart';

class TicketTile extends StatelessWidget {
  final String title;
  final int ticketId;
  final DateTime submitDate;
  String priority;
  String status;
  final bool divider;
  TicketTile(
    this.title,
    this.ticketId,
    this.submitDate,
    this.priority,
    this.status,
    this.divider, {
    Key? key,
  }) : super(key: key);
  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    final ticketItem = Provider.of<TicketService>(context, listen: false)
        .ticketsList
        .firstWhere((element) => element.id == ticketId);
    return GestureDetector(
      onTap: (() {
        Provider.of<TicketChatService>(context, listen: false)
            .fetchSingleTickets(ticketId)
            .then((value) {
          if (value != null) {
            snackBar(context, value);
          }
        }).onError((error, stackTrace) {
          snackBar(context, 'Could not load any messages');
        });
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => TicketChat(title, ticketId),
        ));
      }),
      child: Container(
        // height: screenHight / 10,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cc.greyBorder2),
        ),
        child: Column(
          children: [
            SizedBox(
                // height: 60,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Text(
                  '#$ticketId',
                  style: TextStyle(color: cc.primaryColor, fontSize: 13),
                ),
                const SizedBox(width: 10),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                      color: cc.blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )
                //   ],
                ,
                const Spacer(),
              ],
            )),
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (screenWidth - 40) / 3,
                  child: Consumer<TicketService>(
                      builder: (context, tService, child) {
                    return SizedBox(
                      height: 30,
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text(asProvider.getString('Priority') + ':'),
                            const SizedBox(width: 5),
                            Consumer<TicketService>(
                                builder: (context, tServicem, child) {
                              return PopupMenuButton(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: Provider.of<LanguageService>(
                                                    context,
                                                    listen: false)
                                                .rtl
                                            ? 0
                                            : 7,
                                        right: Provider.of<LanguageService>(
                                                    context,
                                                    listen: false)
                                                .rtl
                                            ? 7
                                            : 0,
                                        top: 3,
                                        bottom: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: tService.priorityColor[priority],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          asProvider
                                              .getString(priority)
                                              .toString()
                                              .capitalize(),
                                          style: TextStyle(
                                              color: cc.pureWhite,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: cc.pureWhite,
                                        )
                                      ],
                                    ),
                                  ),
                                  onSelected: (value) {
                                    if (value != priority.capitalize()) {
                                      tService.priorityChange(
                                          ticketId, value.toString());
                                    }
                                  },
                                  itemBuilder: (context) =>
                                      tService.priorityList
                                          .map((e) => PopupMenuItem(
                                                child: Text(asProvider
                                                    .getString(e)
                                                    .toString()
                                                    .capitalize()),
                                                value: e,
                                              ))
                                          .toList());
                            }),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  height: 30,
                  child: Consumer<TicketService>(
                      builder: (context, tService, child) {
                    return FittedBox(
                      child: Row(
                        children: [
                          Text(asProvider.getString('Status') + ':'),
                          const SizedBox(width: 5),
                          PopupMenuButton(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: Provider.of<LanguageService>(context,
                                              listen: false)
                                          .rtl
                                      ? 0
                                      : 7,
                                  right: Provider.of<LanguageService>(context,
                                              listen: false)
                                          .rtl
                                      ? 7
                                      : 0,
                                  top: 3,
                                  bottom: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ticketItem.status == 'open'
                                    ? const Color(0xff6BB17B)
                                    : const Color(0xffC66060),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    asProvider
                                        .getString(ticketItem.status)
                                        .toString()
                                        .capitalize(),
                                    style: TextStyle(
                                        color: cc.pureWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: cc.pureWhite,
                                  )
                                ],
                              ),
                            ),
                            onSelected: (value) {
                              print(value.toString() + status);
                              if (value != status) {
                                tService.statusChange(
                                    ticketId, value.toString());
                              }
                            },
                            itemBuilder: (context) => ['open', 'close']
                                .map(
                                  (e) => PopupMenuItem(
                                    child: Text(asProvider
                                        .getString(e)
                                        .toString()
                                        .capitalize()),
                                    value: e,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const Spacer(),
                SizedBox(
                  height: 30,
                  child: GestureDetector(
                    onTap: (() {
                      Provider.of<TicketChatService>(context, listen: false)
                          .fetchSingleTickets(ticketId)
                          .then((value) {
                        if (value != null) {
                          snackBar(context, value);
                        }
                      }).onError((error, stackTrace) {
                        snackBar(
                            context,
                            asProvider
                                .getString('Could not load any messages'));
                      });
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            TicketChat(title, ticketId),
                      ));
                    }),
                    child: Container(
                      height: 30,
                      width: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff17A2B8),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/icons/chat_view.svg',
                        height: 20,
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

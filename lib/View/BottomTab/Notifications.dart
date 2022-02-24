import 'package:project_app/Model/NotificationVModel.dart';
import 'package:project_app/View/Entities/Artist.dart';
import 'package:project_app/View/Entities/Club.dart';
import 'package:project_app/View/Entities/Event.dart';
import 'package:project_app/View/Entities/Organizer.dart';
import 'package:project_app/View/Items/NotificationV.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:project_app/providers/NotificationProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore_for_file: file_names

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

NotificationProvider notificationsProvider;
final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
final GlobalKey<AnimatedListState> listKey2 = GlobalKey<AnimatedListState>();

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
    final notificationsProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    notificationsProvider.loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final notificationsProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body:
            Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
          return SafeArea(
              child: RefreshIndicator(
                  onRefresh: () async {
                    notificationsProvider.loadNotifications();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 10, bottom: 20),
                                  child: Text("Notifiche",
                                      style: TextStyle(
                                          color: Color(0xFFf9b701),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34)))),
                        ]),
                        Consumer<NotificationProvider>(
                            builder: (context, customProvider, _) {
                          return (customProvider.notifications != null)
                              ? Column(children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(top: 20, left: 20),
                                      child: Text(
                                        "Nuove",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize: 18),
                                      )),
                                  AnimatedList(
                                    key: listKey,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    initialItemCount: customProvider
                                        .notifications.new_notifications.length,
                                    itemBuilder: (context, index, animation) {
                                      return InkWell(
                                          onTap: () {
                                            print(customProvider
                                                .notifications
                                                .new_notifications[index]
                                                .type_entity);
                                            switch (customProvider
                                                .notifications
                                                .new_notifications[index]
                                                .type_entity) {
                                              case "event":
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Event(
                                                            slug: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .entity_id,
                                                            name: "",
                                                            image: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .image_notification,
                                                            id: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .entity_id)));
                                                break;
                                              case "club":
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Club(
                                                            slug: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .entity_id
                                                                .toString(),
                                                            name: "",
                                                            image: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .image_sender,
                                                            id: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .entity_id
                                                                .toString())));
                                                break;
                                              case "organizer":
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Organizer(
                                                            slug: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .entity_id,
                                                            name: "",
                                                            image: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .image_sender,
                                                            id: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .entity_id)));
                                                break;
                                              case "artist":
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Artist(
                                                            slug: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .entity_id,
                                                            name: "",
                                                            image: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .image_notification,
                                                            id: customProvider
                                                                .notifications
                                                                .new_notifications[
                                                                    index]
                                                                .entity_id)));
                                                break;
                                              default:
                                            }
                                          },
                                          onLongPress: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(20),
                                                            topLeft:
                                                                Radius.circular(
                                                                    20))),
                                                backgroundColor:
                                                    Color(0xFF222222),
                                                builder: (context) => Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    height: size.height / 5,
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              customProvider.deleteNotification(
                                                                  customProvider
                                                                      .notifications
                                                                      .new_notifications[
                                                                          index]
                                                                      .id);
                                                              final removedItem =
                                                                  customProvider
                                                                      .notifications
                                                                      .new_notifications
                                                                      .removeAt(
                                                                          index);
                                                              listKey
                                                                  .currentState
                                                                  .removeItem(
                                                                index,
                                                                (BuildContext
                                                                        context,
                                                                    Animation<
                                                                            double>
                                                                        animation) {
                                                                  return _buildRemovedItem(
                                                                      removedItem,
                                                                      context,
                                                                      animation);
                                                                },
                                                              );

                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    'Elimina notifica',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red)))),
                                                      ],
                                                    )));
                                          },
                                          child: NotificationV(
                                              // key: listKey,
                                              animation: animation,
                                              notification: customProvider
                                                  .notifications
                                                  .new_notifications[index]));
                                    },
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(top: 20, left: 20),
                                      child: Text(
                                        "Vecchie",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize: 18),
                                      )),
                                  AnimatedList(
                                    key: listKey2,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    initialItemCount: customProvider
                                        .notifications.old_notifications.length,
                                    itemBuilder: (context, index, animation) {
                                      return InkWell(
                                          onLongPress: () {
                                            // setState(() {
                                            //   customProvider.not.selected = true;
                                            // });
                                            showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(20),
                                                            topLeft:
                                                                Radius.circular(
                                                                    20))),
                                                backgroundColor:
                                                    Color(0xFF222222),
                                                builder: (context) => Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    height: size.height / 5,
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              customProvider.deleteNotification(
                                                                  customProvider
                                                                      .notifications
                                                                      .old_notifications[
                                                                          index]
                                                                      .id);

                                                              final removedItem =
                                                                  customProvider
                                                                      .notifications
                                                                      .old_notifications
                                                                      .removeAt(
                                                                          index);
                                                              listKey2
                                                                  .currentState
                                                                  .removeItem(
                                                                index,
                                                                (BuildContext
                                                                        context,
                                                                    Animation<
                                                                            double>
                                                                        animation) {
                                                                  return _buildRemovedItem(
                                                                      removedItem,
                                                                      context,
                                                                      animation);
                                                                },
                                                              );

                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    'Elimina notifica',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red)))),
                                                      ],
                                                    )));
                                          },
                                          child: NotificationV(
                                              // key: listKey,
                                              animation: animation,
                                              notification: customProvider
                                                  .notifications
                                                  .old_notifications[index]));
                                    },
                                  )
                                ])
                              : CircularProgressIndicator();
                        }),
                      ],
                    ),
                  )));
        }));
  }
}

Widget _buildRemovedItem(NotificationVModel notification, BuildContext context,
    Animation<double> animation) {
  return NotificationV(
    animation: animation,
    notification: notification,
    // selected: false,
    // No gesture detector here: we don't want removed items to be interactive.
  );
}

// Insert the "next item" into the list model.
// void _insert() {
//   final int index =
//       _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
//   _list.insert(index, _nextItem++);
// }

// Remove the selected item from the list model.

import 'package:anime_app/features/auth/screens/inbox_screen.dart';
import 'package:anime_app/models/message_data.dart';
import 'package:anime_app/theme/theme.dart';
import 'package:anime_app/widgets/avatar.dart';

import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverToBoxAdapter(
        //   child: Stories(),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(_delegate, childCount: 15),
        )
      ],
    );
  }

  Widget _delegate(BuildContext context, int index) {
    {
      // return Text('dsfdsfdsfsdfsdf');
      // final Faker faker = Faker();
      // final date = Helpers.randomDate().toString();
      return _MessageTitle(
        messageData: MessageData(
          senderName: 'faker.person.name()',
          message: 'faker.lorem.sentence()',
          messageData: 'date',
          dateMessage: 'Jiffy(date).fromNow()',
          profilePicture: 'Helpers.randomPictureUrl()',
        ),
      );
      // );
    }
  }
}

class _MessageTitle extends StatelessWidget {
  final MessageData messageData;
  const _MessageTitle({
    super.key,
    required this.messageData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(InboxScreen.route(messageData));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.2,
          ),
        )),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: messageData.profilePicture),
              ),
              //without adding expanded the column doesn't know when to stop
              //so there'll be overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        messageData.senderName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        messageData.message,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textFaded,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      messageData.dateMessage.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFaded,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textLigth,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

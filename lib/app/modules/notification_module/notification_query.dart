class NotificationQuery {
  static const String myNotifications = '''
    query MyNotifications{
      myNotifications(orderBy: "-date_created"){
        edges{
          node{
            title
            contents
            route
            dateCreated
            dateRead
            notificationType
          }
        }
      }
    }
  ''';

  static const String countNewNotifications = '''
    query CountNewNotifications{
      countNewNotifications
    }
  ''';
}

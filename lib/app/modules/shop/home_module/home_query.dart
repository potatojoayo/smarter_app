class HomeQuery {
  static const String banners = '''
  		query Banners {
			banners {
				id
				name
				image
				order
			}
		}
  ''';
  static const String notices = '''
  query Notices {
    notices(first: 5, isActive: true) {
      totalCount
      edges {
        node {
          noticeId
          title
          contents
          dateCreated
          dateUpdated
          user {
            name
            identification
          }
        }
      }
    }
  }
 ''';
}

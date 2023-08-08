class FaqQuery {
  static const String faqs = '''
  query Faqs {
    faqs(isActive: true) {
      totalCount
      edges {
        node {
          faqId
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

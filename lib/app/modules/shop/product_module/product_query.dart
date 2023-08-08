class ProductQuery {
  static const String brandList = '''
  query BrandList(\$subCategory: String){
    brandList(subCategory: \$subCategory)
  }
  ''';
  static const String categories = """
    query Categories(){
      categories {
        name
        children {
          name
          }
      }
    }
  """;
  static const String productMasters = """
    query ProductMasters(\$category: String, \$subCategory: String, \$brand: String, \$name: String, \$first: Int, \$userId: ID){
      productMasters(state: "판매중", category_Name: \$category, subCategory_Name: \$subCategory, brand_Name: \$brand, name_Icontains: \$name, first: \$first,
     orderdetail_OrderMaster_UserId: \$userId
       ) {
        edges{
          node{
            id
            productMasterId
            name
            thumbnail
            priceGym
            colors
            priceDelivery
            brand{
              name
            }
            category {
              name
            }
            subCategory{
              name
            }
            products(state: "판매중") {
              id
              size
              color
              priceAdditional
              state
            }
            drafts {
              id
              image
              priceWork
              priceWorkLabor
              font
              threadColor
              memo
            }
             defaultDraft{
              id
              image
              priceWork
              priceWorkLabor
              font
              threadColor
            }
          }
        }
      }
    }
  """;
  static const String productMasterNode = """
    query ProductMasterNode(\$id: ID!){
      productMasterNode(id:\$id) {
        id
        productMasterId
        name
        thumbnail
        descriptionImage
        needDraft
        imageUrls
        priceDelivery
        priceGym
        products {
          id
          size
          color
          priceAdditional
          state
        }
        colors
        sizes
        drafts {
          id
          image
          priceWork
          priceWorkLabor
          font
          threadColor
          memo
        }
        brand{
          name
        }
        category {
          name
        }
        subCategory{
          name
        }
      }
    }
  """;

  static const String recentOrderedProducts = """
    query RecentOrderedProducts{
      recentOrderedProducts {
        edges{
          node{
            id
            productMasterId
            name
            thumbnail
            priceGym
            brand{
              name
            }
            category {
              name
            }
            subCategory{
              name
            }
          }
        }
      }
    }
  """;
}

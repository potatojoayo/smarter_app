// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAddress$Mutation$DeleteAddress
    _$DeleteAddress$Mutation$DeleteAddressFromJson(Map<String, dynamic> json) =>
        DeleteAddress$Mutation$DeleteAddress()
          ..success = json['success'] as bool?
          ..message = json['message'] as String?;

Map<String, dynamic> _$DeleteAddress$Mutation$DeleteAddressToJson(
        DeleteAddress$Mutation$DeleteAddress instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

DeleteAddress$Mutation _$DeleteAddress$MutationFromJson(
        Map<String, dynamic> json) =>
    DeleteAddress$Mutation()
      ..deleteAddress = json['deleteAddress'] == null
          ? null
          : DeleteAddress$Mutation$DeleteAddress.fromJson(
              json['deleteAddress'] as Map<String, dynamic>);

Map<String, dynamic> _$DeleteAddress$MutationToJson(
        DeleteAddress$Mutation instance) =>
    <String, dynamic>{
      'deleteAddress': instance.deleteAddress?.toJson(),
    };

VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyType
    _$VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyTypeFromJson(
            Map<String, dynamic> json) =>
        VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyType()
          ..name = json['name'] as String;

Map<String, dynamic>
    _$VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyTypeToJson(
            VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyType
                instance) =>
        <String, dynamic>{
          'name': instance.name,
        };

VerifyToken$Mutation$VerifyToken$UserType$GymType
    _$VerifyToken$Mutation$VerifyToken$UserType$GymTypeFromJson(
            Map<String, dynamic> json) =>
        VerifyToken$Mutation$VerifyToken$UserType$GymType()
          ..name = json['name'] as String
          ..address = json['address'] as String?
          ..detailAddress = json['detailAddress'] as String?
          ..zipCode = json['zipCode'] as String?
          ..email = json['email'] as String?
          ..businessRegistrationNumber =
              json['businessRegistrationNumber'] as String?
          ..businessRegistrationCertificate =
              json['businessRegistrationCertificate'] as String?
          ..agency = json['agency'] == null
              ? null
              : VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyType
                  .fromJson(json['agency'] as Map<String, dynamic>);

Map<String, dynamic> _$VerifyToken$Mutation$VerifyToken$UserType$GymTypeToJson(
        VerifyToken$Mutation$VerifyToken$UserType$GymType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'detailAddress': instance.detailAddress,
      'zipCode': instance.zipCode,
      'email': instance.email,
      'businessRegistrationNumber': instance.businessRegistrationNumber,
      'businessRegistrationCertificate':
          instance.businessRegistrationCertificate,
      'agency': instance.agency?.toJson(),
    };

VerifyToken$Mutation$VerifyToken$UserType
    _$VerifyToken$Mutation$VerifyToken$UserTypeFromJson(
            Map<String, dynamic> json) =>
        VerifyToken$Mutation$VerifyToken$UserType()
          ..id = json['id'] as String
          ..identification = json['identification'] as String
          ..name = json['name'] as String
          ..phone = json['phone'] as String
          ..gym = json['gym'] == null
              ? null
              : VerifyToken$Mutation$VerifyToken$UserType$GymType.fromJson(
                  json['gym'] as Map<String, dynamic>);

Map<String, dynamic> _$VerifyToken$Mutation$VerifyToken$UserTypeToJson(
        VerifyToken$Mutation$VerifyToken$UserType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identification': instance.identification,
      'name': instance.name,
      'phone': instance.phone,
      'gym': instance.gym?.toJson(),
    };

VerifyToken$Mutation$VerifyToken _$VerifyToken$Mutation$VerifyTokenFromJson(
        Map<String, dynamic> json) =>
    VerifyToken$Mutation$VerifyToken()
      ..isActive = json['isActive'] as bool?
      ..user = json['user'] == null
          ? null
          : VerifyToken$Mutation$VerifyToken$UserType.fromJson(
              json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$VerifyToken$Mutation$VerifyTokenToJson(
        VerifyToken$Mutation$VerifyToken instance) =>
    <String, dynamic>{
      'isActive': instance.isActive,
      'user': instance.user?.toJson(),
    };

VerifyToken$Mutation _$VerifyToken$MutationFromJson(
        Map<String, dynamic> json) =>
    VerifyToken$Mutation()
      ..verifyToken = json['verifyToken'] == null
          ? null
          : VerifyToken$Mutation$VerifyToken.fromJson(
              json['verifyToken'] as Map<String, dynamic>);

Map<String, dynamic> _$VerifyToken$MutationToJson(
        VerifyToken$Mutation instance) =>
    <String, dynamic>{
      'verifyToken': instance.verifyToken?.toJson(),
    };

OrderMasterAndAddresses$Query$AddressType
    _$OrderMasterAndAddresses$Query$AddressTypeFromJson(
            Map<String, dynamic> json) =>
        OrderMasterAndAddresses$Query$AddressType()
          ..id = json['id'] as String
          ..name = json['name'] as String
          ..receiver = json['receiver'] as String
          ..phone = json['phone'] as String
          ..zipCode = json['zipCode'] as String?
          ..address = json['address'] as String
          ..detailAddress = json['detailAddress'] as String?
          ..kw$default = json['default'] as bool;

Map<String, dynamic> _$OrderMasterAndAddresses$Query$AddressTypeToJson(
        OrderMasterAndAddresses$Query$AddressType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'receiver': instance.receiver,
      'phone': instance.phone,
      'zipCode': instance.zipCode,
      'address': instance.address,
      'detailAddress': instance.detailAddress,
      'default': instance.kw$default,
    };

OrderMasterAndAddresses$Query$CouponType$CouponMasterType
    _$OrderMasterAndAddresses$Query$CouponType$CouponMasterTypeFromJson(
            Map<String, dynamic> json) =>
        OrderMasterAndAddresses$Query$CouponType$CouponMasterType()
          ..name = json['name'] as String?;

Map<String,
    dynamic> _$OrderMasterAndAddresses$Query$CouponType$CouponMasterTypeToJson(
        OrderMasterAndAddresses$Query$CouponType$CouponMasterType instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

OrderMasterAndAddresses$Query$CouponType
    _$OrderMasterAndAddresses$Query$CouponTypeFromJson(
            Map<String, dynamic> json) =>
        OrderMasterAndAddresses$Query$CouponType()
          ..id = json['id'] as String
          ..couponMaster =
              OrderMasterAndAddresses$Query$CouponType$CouponMasterType
                  .fromJson(json['couponMaster'] as Map<String, dynamic>)
          ..price = json['price'] as int?
          ..startOfUse = fromGraphQLDateTimeNullableToDartDateTimeNullable(
              json['startOfUse'] as String)
          ..endOfUse = fromGraphQLDateTimeNullableToDartDateTimeNullable(
              json['endOfUse'] as String)
          ..dateUsed = fromGraphQLDateTimeNullableToDartDateTimeNullable(
              json['dateUsed'] as String?);

Map<String, dynamic> _$OrderMasterAndAddresses$Query$CouponTypeToJson(
        OrderMasterAndAddresses$Query$CouponType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'couponMaster': instance.couponMaster.toJson(),
      'price': instance.price,
      'startOfUse': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.startOfUse),
      'endOfUse':
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.endOfUse),
      'dateUsed':
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.dateUsed),
    };

OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandType
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandTypeFromJson(
            Map<String, dynamic> json) =>
        OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandType()
          ..name = json['name'] as String;

Map<String, dynamic>
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandTypeToJson(
            OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandType
                instance) =>
        <String, dynamic>{
          'name': instance.name,
        };

OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryTypeFromJson(
            Map<String, dynamic> json) =>
        OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType()
          ..name = json['name'] as String;

Map<String, dynamic>
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryTypeToJson(
            OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType
                instance) =>
        <String, dynamic>{
          'name': instance.name,
        };

OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNodeFromJson(
            Map<String, dynamic> json) =>
        OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode()
          ..name = json['name'] as String
          ..thumbnail = json['thumbnail'] as String?
          ..brand =
              OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandType
                  .fromJson(json['brand'] as Map<String, dynamic>)
          ..category =
              OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType
                  .fromJson(json['category'] as Map<String, dynamic>)
          ..subCategory =
              OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType
                  .fromJson(json['subCategory'] as Map<String, dynamic>);

Map<String, dynamic>
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNodeToJson(
            OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode
                instance) =>
        <String, dynamic>{
          'name': instance.name,
          'thumbnail': instance.thumbnail,
          'brand': instance.brand.toJson(),
          'category': instance.category.toJson(),
          'subCategory': instance.subCategory.toJson(),
        };

OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNodeFromJson(
            Map<String, dynamic> json) =>
        OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode()
          ..color = json['color'] as String
          ..size = json['size'] as String
          ..productMaster =
              OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode
                  .fromJson(json['productMaster'] as Map<String, dynamic>)
          ..name = json['name'] as String;

Map<String, dynamic>
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNodeToJson(
            OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode
                instance) =>
        <String, dynamic>{
          'color': instance.color,
          'size': instance.size,
          'productMaster': instance.productMaster.toJson(),
          'name': instance.name,
        };

OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailTypeFromJson(
            Map<String, dynamic> json) =>
        OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType()
          ..state = json['state'] as String
          ..product =
              OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode
                  .fromJson(json['product'] as Map<String, dynamic>)
          ..quantity = json['quantity'] as int
          ..priceTotal = json['priceTotal'] as int
          ..priceProducts = json['priceProducts'] as int
          ..priceWork = json['priceWork'] as int
          ..priceWorkLabor = json['priceWorkLabor'] as int
          ..priceOption = json['priceOption'] as int;

Map<String, dynamic>
    _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailTypeToJson(
            OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType
                instance) =>
        <String, dynamic>{
          'state': instance.state,
          'product': instance.product.toJson(),
          'quantity': instance.quantity,
          'priceTotal': instance.priceTotal,
          'priceProducts': instance.priceProducts,
          'priceWork': instance.priceWork,
          'priceWorkLabor': instance.priceWorkLabor,
          'priceOption': instance.priceOption,
        };

OrderMasterAndAddresses$Query$OrderMasterType
    _$OrderMasterAndAddresses$Query$OrderMasterTypeFromJson(
            Map<String, dynamic> json) =>
        OrderMasterAndAddresses$Query$OrderMasterType()
          ..id = json['id'] as String
          ..orderNumber = json['orderNumber'] as String
          ..priceDelivery = json['priceDelivery'] as int
          ..priceTotalProducts = json['priceTotalProducts'] as int?
          ..priceToPay = json['priceToPay'] as int?
          ..orderName = json['orderName'] as String?
          ..receiver = json['receiver'] as String
          ..address = json['address'] as String
          ..detailAddress = json['detailAddress'] as String?
          ..zipCode = json['zipCode'] as String?
          ..phone = json['phone'] as String
          ..details = (json['details'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$OrderMasterAndAddresses$Query$OrderMasterTypeToJson(
        OrderMasterAndAddresses$Query$OrderMasterType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'priceDelivery': instance.priceDelivery,
      'priceTotalProducts': instance.priceTotalProducts,
      'priceToPay': instance.priceToPay,
      'orderName': instance.orderName,
      'receiver': instance.receiver,
      'address': instance.address,
      'detailAddress': instance.detailAddress,
      'zipCode': instance.zipCode,
      'phone': instance.phone,
      'details': instance.details?.map((e) => e?.toJson()).toList(),
    };

OrderMasterAndAddresses$Query _$OrderMasterAndAddresses$QueryFromJson(
        Map<String, dynamic> json) =>
    OrderMasterAndAddresses$Query()
      ..myAddresses = (json['myAddresses'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : OrderMasterAndAddresses$Query$AddressType.fromJson(
                  e as Map<String, dynamic>))
          .toList()
      ..didUseCouponToday = json['didUseCouponToday'] as bool?
      ..myCoupons = (json['myCoupons'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : OrderMasterAndAddresses$Query$CouponType.fromJson(
                  e as Map<String, dynamic>))
          .toList()
      ..orderMaster = json['orderMaster'] == null
          ? null
          : OrderMasterAndAddresses$Query$OrderMasterType.fromJson(
              json['orderMaster'] as Map<String, dynamic>);

Map<String, dynamic> _$OrderMasterAndAddresses$QueryToJson(
        OrderMasterAndAddresses$Query instance) =>
    <String, dynamic>{
      'myAddresses': instance.myAddresses?.map((e) => e?.toJson()).toList(),
      'didUseCouponToday': instance.didUseCouponToday,
      'myCoupons': instance.myCoupons?.map((e) => e?.toJson()).toList(),
      'orderMaster': instance.orderMaster?.toJson(),
    };

MyCoupons$Query$CouponType$CouponMasterType
    _$MyCoupons$Query$CouponType$CouponMasterTypeFromJson(
            Map<String, dynamic> json) =>
        MyCoupons$Query$CouponType$CouponMasterType()
          ..name = json['name'] as String?;

Map<String, dynamic> _$MyCoupons$Query$CouponType$CouponMasterTypeToJson(
        MyCoupons$Query$CouponType$CouponMasterType instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

MyCoupons$Query$CouponType _$MyCoupons$Query$CouponTypeFromJson(
        Map<String, dynamic> json) =>
    MyCoupons$Query$CouponType()
      ..id = json['id'] as String
      ..couponMaster = MyCoupons$Query$CouponType$CouponMasterType.fromJson(
          json['couponMaster'] as Map<String, dynamic>)
      ..price = json['price'] as int?
      ..startOfUse = fromGraphQLDateTimeNullableToDartDateTimeNullable(
          json['startOfUse'] as String)
      ..endOfUse = fromGraphQLDateTimeNullableToDartDateTimeNullable(
          json['endOfUse'] as String)
      ..dateUsed = fromGraphQLDateTimeNullableToDartDateTimeNullable(
          json['dateUsed'] as String);

Map<String, dynamic> _$MyCoupons$Query$CouponTypeToJson(
        MyCoupons$Query$CouponType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'couponMaster': instance.couponMaster.toJson(),
      'price': instance.price,
      'startOfUse': fromDartDateTimeNullableToGraphQLDateTimeNullable(
          instance.startOfUse),
      'endOfUse':
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.endOfUse),
      'dateUsed':
          fromDartDateTimeNullableToGraphQLDateTimeNullable(instance.dateUsed),
    };

MyCoupons$Query _$MyCoupons$QueryFromJson(Map<String, dynamic> json) =>
    MyCoupons$Query()
      ..myCoupons = (json['myCoupons'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : MyCoupons$Query$CouponType.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MyCoupons$QueryToJson(MyCoupons$Query instance) =>
    <String, dynamic>{
      'myCoupons': instance.myCoupons?.map((e) => e?.toJson()).toList(),
    };

OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterType
    _$OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterTypeFromJson(
            Map<String, dynamic> json) =>
        OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterType()
          ..id = json['id'] as String;

Map<String, dynamic>
    _$OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterTypeToJson(
            OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterType
                instance) =>
        <String, dynamic>{
          'id': instance.id,
        };

OrderBySmarterMoney$Mutation$OrderBySmarterMoney
    _$OrderBySmarterMoney$Mutation$OrderBySmarterMoneyFromJson(
            Map<String, dynamic> json) =>
        OrderBySmarterMoney$Mutation$OrderBySmarterMoney()
          ..success = json['success'] as bool?
          ..orderMaster = json['orderMaster'] == null
              ? null
              : OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterType
                  .fromJson(json['orderMaster'] as Map<String, dynamic>);

Map<String, dynamic> _$OrderBySmarterMoney$Mutation$OrderBySmarterMoneyToJson(
        OrderBySmarterMoney$Mutation$OrderBySmarterMoney instance) =>
    <String, dynamic>{
      'success': instance.success,
      'orderMaster': instance.orderMaster?.toJson(),
    };

OrderBySmarterMoney$Mutation _$OrderBySmarterMoney$MutationFromJson(
        Map<String, dynamic> json) =>
    OrderBySmarterMoney$Mutation()
      ..orderBySmarterMoney = json['orderBySmarterMoney'] == null
          ? null
          : OrderBySmarterMoney$Mutation$OrderBySmarterMoney.fromJson(
              json['orderBySmarterMoney'] as Map<String, dynamic>);

Map<String, dynamic> _$OrderBySmarterMoney$MutationToJson(
        OrderBySmarterMoney$Mutation instance) =>
    <String, dynamic>{
      'orderBySmarterMoney': instance.orderBySmarterMoney?.toJson(),
    };

CancelOrder$Mutation$UserCancelOrder
    _$CancelOrder$Mutation$UserCancelOrderFromJson(Map<String, dynamic> json) =>
        CancelOrder$Mutation$UserCancelOrder()
          ..success = json['success'] as bool
          ..message = json['message'] as String;

Map<String, dynamic> _$CancelOrder$Mutation$UserCancelOrderToJson(
        CancelOrder$Mutation$UserCancelOrder instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

CancelOrder$Mutation _$CancelOrder$MutationFromJson(
        Map<String, dynamic> json) =>
    CancelOrder$Mutation()
      ..userCancelOrder = json['userCancelOrder'] == null
          ? null
          : CancelOrder$Mutation$UserCancelOrder.fromJson(
              json['userCancelOrder'] as Map<String, dynamic>);

Map<String, dynamic> _$CancelOrder$MutationToJson(
        CancelOrder$Mutation instance) =>
    <String, dynamic>{
      'userCancelOrder': instance.userCancelOrder?.toJson(),
    };

CreateUserReturnRequest$Mutation$CreateUserReturnRequest
    _$CreateUserReturnRequest$Mutation$CreateUserReturnRequestFromJson(
            Map<String, dynamic> json) =>
        CreateUserReturnRequest$Mutation$CreateUserReturnRequest()
          ..success = json['success'] as bool?
          ..message = json['message'] as String?;

Map<String,
    dynamic> _$CreateUserReturnRequest$Mutation$CreateUserReturnRequestToJson(
        CreateUserReturnRequest$Mutation$CreateUserReturnRequest instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

CreateUserReturnRequest$Mutation _$CreateUserReturnRequest$MutationFromJson(
        Map<String, dynamic> json) =>
    CreateUserReturnRequest$Mutation()
      ..createUserReturnRequest = json['createUserReturnRequest'] == null
          ? null
          : CreateUserReturnRequest$Mutation$CreateUserReturnRequest.fromJson(
              json['createUserReturnRequest'] as Map<String, dynamic>);

Map<String, dynamic> _$CreateUserReturnRequest$MutationToJson(
        CreateUserReturnRequest$Mutation instance) =>
    <String, dynamic>{
      'createUserReturnRequest': instance.createUserReturnRequest?.toJson(),
    };

CreateUserChangeRequest$Mutation$CreateUserChangeRequest
    _$CreateUserChangeRequest$Mutation$CreateUserChangeRequestFromJson(
            Map<String, dynamic> json) =>
        CreateUserChangeRequest$Mutation$CreateUserChangeRequest()
          ..success = json['success'] as bool?
          ..message = json['message'] as String?;

Map<String,
    dynamic> _$CreateUserChangeRequest$Mutation$CreateUserChangeRequestToJson(
        CreateUserChangeRequest$Mutation$CreateUserChangeRequest instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

CreateUserChangeRequest$Mutation _$CreateUserChangeRequest$MutationFromJson(
        Map<String, dynamic> json) =>
    CreateUserChangeRequest$Mutation()
      ..createUserChangeRequest = json['createUserChangeRequest'] == null
          ? null
          : CreateUserChangeRequest$Mutation$CreateUserChangeRequest.fromJson(
              json['createUserChangeRequest'] as Map<String, dynamic>);

Map<String, dynamic> _$CreateUserChangeRequest$MutationToJson(
        CreateUserChangeRequest$Mutation instance) =>
    <String, dynamic>{
      'createUserChangeRequest': instance.createUserChangeRequest?.toJson(),
    };

ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductType
    _$ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductTypeFromJson(
            Map<String, dynamic> json) =>
        ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductType()
          ..color = json['color'] as String
          ..size = json['size'] as String
          ..priceAdditional = json['priceAdditional'] as int;

Map<String, dynamic>
    _$ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductTypeToJson(
            ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductType
                instance) =>
        <String, dynamic>{
          'color': instance.color,
          'size': instance.size,
          'priceAdditional': instance.priceAdditional,
        };

ChangeDetailOfOrderDetail$Query$ChangeDetailType
    _$ChangeDetailOfOrderDetail$Query$ChangeDetailTypeFromJson(
            Map<String, dynamic> json) =>
        ChangeDetailOfOrderDetail$Query$ChangeDetailType()
          ..changingQuantity = json['changingQuantity'] as int?
          ..changingProduct = json['changingProduct'] == null
              ? null
              : ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductType
                  .fromJson(json['changingProduct'] as Map<String, dynamic>);

Map<String, dynamic> _$ChangeDetailOfOrderDetail$Query$ChangeDetailTypeToJson(
        ChangeDetailOfOrderDetail$Query$ChangeDetailType instance) =>
    <String, dynamic>{
      'changingQuantity': instance.changingQuantity,
      'changingProduct': instance.changingProduct?.toJson(),
    };

ChangeDetailOfOrderDetail$Query _$ChangeDetailOfOrderDetail$QueryFromJson(
        Map<String, dynamic> json) =>
    ChangeDetailOfOrderDetail$Query()
      ..changeDetailOfOrderDetail = json['changeDetailOfOrderDetail'] == null
          ? null
          : ChangeDetailOfOrderDetail$Query$ChangeDetailType.fromJson(
              json['changeDetailOfOrderDetail'] as Map<String, dynamic>);

Map<String, dynamic> _$ChangeDetailOfOrderDetail$QueryToJson(
        ChangeDetailOfOrderDetail$Query instance) =>
    <String, dynamic>{
      'changeDetailOfOrderDetail': instance.changeDetailOfOrderDetail?.toJson(),
    };

ChangeOrderDelivery$Mutation$ChangeOrderDelivery
    _$ChangeOrderDelivery$Mutation$ChangeOrderDeliveryFromJson(
            Map<String, dynamic> json) =>
        ChangeOrderDelivery$Mutation$ChangeOrderDelivery()
          ..success = json['success'] as bool?;

Map<String, dynamic> _$ChangeOrderDelivery$Mutation$ChangeOrderDeliveryToJson(
        ChangeOrderDelivery$Mutation$ChangeOrderDelivery instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

ChangeOrderDelivery$Mutation _$ChangeOrderDelivery$MutationFromJson(
        Map<String, dynamic> json) =>
    ChangeOrderDelivery$Mutation()
      ..changeOrderDelivery = json['changeOrderDelivery'] == null
          ? null
          : ChangeOrderDelivery$Mutation$ChangeOrderDelivery.fromJson(
              json['changeOrderDelivery'] as Map<String, dynamic>);

Map<String, dynamic> _$ChangeOrderDelivery$MutationToJson(
        ChangeOrderDelivery$Mutation instance) =>
    <String, dynamic>{
      'changeOrderDelivery': instance.changeOrderDelivery?.toJson(),
    };

MyDrafts$Query$NewDraftType _$MyDrafts$Query$NewDraftTypeFromJson(
        Map<String, dynamic> json) =>
    MyDrafts$Query$NewDraftType()
      ..id = json['id'] as String
      ..categoryName = json['categoryName'] as String?
      ..subCategoryName = json['subCategoryName'] as String?
      ..image = json['image'] as String?
      ..printing = json['printing'] as String?
      ..priceWork = json['priceWork'] as int?
      ..font = json['font'] as String?
      ..threadColor = json['threadColor'] as String?;

Map<String, dynamic> _$MyDrafts$Query$NewDraftTypeToJson(
        MyDrafts$Query$NewDraftType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'subCategoryName': instance.subCategoryName,
      'image': instance.image,
      'printing': instance.printing,
      'priceWork': instance.priceWork,
      'font': instance.font,
      'threadColor': instance.threadColor,
    };

MyDrafts$Query _$MyDrafts$QueryFromJson(Map<String, dynamic> json) =>
    MyDrafts$Query()
      ..myDrafts = (json['myDrafts'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : MyDrafts$Query$NewDraftType.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MyDrafts$QueryToJson(MyDrafts$Query instance) =>
    <String, dynamic>{
      'myDrafts': instance.myDrafts?.map((e) => e?.toJson()).toList(),
    };

MyAddressesAndProductMaster$Query$ProductMasterType$ProductType
    _$MyAddressesAndProductMaster$Query$ProductMasterType$ProductTypeFromJson(
            Map<String, dynamic> json) =>
        MyAddressesAndProductMaster$Query$ProductMasterType$ProductType()
          ..productId = json['productId'] as int?
          ..priceAdditional = json['priceAdditional'] as int
          ..color = json['color'] as String
          ..size = json['size'] as String;

Map<String, dynamic>
    _$MyAddressesAndProductMaster$Query$ProductMasterType$ProductTypeToJson(
            MyAddressesAndProductMaster$Query$ProductMasterType$ProductType
                instance) =>
        <String, dynamic>{
          'productId': instance.productId,
          'priceAdditional': instance.priceAdditional,
          'color': instance.color,
          'size': instance.size,
        };

MyAddressesAndProductMaster$Query$ProductMasterType
    _$MyAddressesAndProductMaster$Query$ProductMasterTypeFromJson(
            Map<String, dynamic> json) =>
        MyAddressesAndProductMaster$Query$ProductMasterType()
          ..sizes = (json['sizes'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList()
          ..colors = (json['colors'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList()
          ..products = (json['products'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : MyAddressesAndProductMaster$Query$ProductMasterType$ProductType
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic>
    _$MyAddressesAndProductMaster$Query$ProductMasterTypeToJson(
            MyAddressesAndProductMaster$Query$ProductMasterType instance) =>
        <String, dynamic>{
          'sizes': instance.sizes,
          'colors': instance.colors,
          'products': instance.products?.map((e) => e?.toJson()).toList(),
        };

MyAddressesAndProductMaster$Query$AddressType
    _$MyAddressesAndProductMaster$Query$AddressTypeFromJson(
            Map<String, dynamic> json) =>
        MyAddressesAndProductMaster$Query$AddressType()
          ..id = json['id'] as String
          ..name = json['name'] as String
          ..receiver = json['receiver'] as String
          ..phone = json['phone'] as String
          ..zipCode = json['zipCode'] as String?
          ..address = json['address'] as String
          ..detailAddress = json['detailAddress'] as String?
          ..kw$default = json['default'] as bool;

Map<String, dynamic> _$MyAddressesAndProductMaster$Query$AddressTypeToJson(
        MyAddressesAndProductMaster$Query$AddressType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'receiver': instance.receiver,
      'phone': instance.phone,
      'zipCode': instance.zipCode,
      'address': instance.address,
      'detailAddress': instance.detailAddress,
      'default': instance.kw$default,
    };

MyAddressesAndProductMaster$Query _$MyAddressesAndProductMaster$QueryFromJson(
        Map<String, dynamic> json) =>
    MyAddressesAndProductMaster$Query()
      ..productMaster = json['productMaster'] == null
          ? null
          : MyAddressesAndProductMaster$Query$ProductMasterType.fromJson(
              json['productMaster'] as Map<String, dynamic>)
      ..myAddresses = (json['myAddresses'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : MyAddressesAndProductMaster$Query$AddressType.fromJson(
                  e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MyAddressesAndProductMaster$QueryToJson(
        MyAddressesAndProductMaster$Query instance) =>
    <String, dynamic>{
      'productMaster': instance.productMaster?.toJson(),
      'myAddresses': instance.myAddresses?.map((e) => e?.toJson()).toList(),
    };

DeleteAddressArguments _$DeleteAddressArgumentsFromJson(
        Map<String, dynamic> json) =>
    DeleteAddressArguments(
      addressId: json['addressId'] as int,
    );

Map<String, dynamic> _$DeleteAddressArgumentsToJson(
        DeleteAddressArguments instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
    };

VerifyTokenArguments _$VerifyTokenArgumentsFromJson(
        Map<String, dynamic> json) =>
    VerifyTokenArguments(
      token: json['token'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$VerifyTokenArgumentsToJson(
        VerifyTokenArguments instance) =>
    <String, dynamic>{
      'token': instance.token,
      'fcmToken': instance.fcmToken,
    };

OrderMasterAndAddressesArguments _$OrderMasterAndAddressesArgumentsFromJson(
        Map<String, dynamic> json) =>
    OrderMasterAndAddressesArguments(
      orderMasterId: json['orderMasterId'] as int,
    );

Map<String, dynamic> _$OrderMasterAndAddressesArgumentsToJson(
        OrderMasterAndAddressesArguments instance) =>
    <String, dynamic>{
      'orderMasterId': instance.orderMasterId,
    };

OrderBySmarterMoneyArguments _$OrderBySmarterMoneyArgumentsFromJson(
        Map<String, dynamic> json) =>
    OrderBySmarterMoneyArguments(
      orderMasterId: json['orderMasterId'] as int,
      receiver: json['receiver'] as String,
      phone: json['phone'] as String,
      zipCode: json['zipCode'] as String,
      address: json['address'] as String,
      detailAddress: json['detailAddress'] as String?,
      deliveryRequest: json['deliveryRequest'] as String?,
      smarterMoney: json['smarterMoney'] as int,
      couponId: json['couponId'] as int?,
    );

Map<String, dynamic> _$OrderBySmarterMoneyArgumentsToJson(
        OrderBySmarterMoneyArguments instance) =>
    <String, dynamic>{
      'orderMasterId': instance.orderMasterId,
      'receiver': instance.receiver,
      'phone': instance.phone,
      'zipCode': instance.zipCode,
      'address': instance.address,
      'detailAddress': instance.detailAddress,
      'deliveryRequest': instance.deliveryRequest,
      'smarterMoney': instance.smarterMoney,
      'couponId': instance.couponId,
    };

CancelOrderArguments _$CancelOrderArgumentsFromJson(
        Map<String, dynamic> json) =>
    CancelOrderArguments(
      orderMasterId: json['orderMasterId'] as int,
    );

Map<String, dynamic> _$CancelOrderArgumentsToJson(
        CancelOrderArguments instance) =>
    <String, dynamic>{
      'orderMasterId': instance.orderMasterId,
    };

CreateUserReturnRequestArguments _$CreateUserReturnRequestArgumentsFromJson(
        Map<String, dynamic> json) =>
    CreateUserReturnRequestArguments(
      orderDetailId: json['orderDetailId'] as int,
      quantity: json['quantity'] as int,
      returnReason: json['returnReason'] as String?,
      receiver: json['receiver'] as String?,
      phone: json['phone'] as String?,
      zipCode: json['zipCode'] as String?,
      address: json['address'] as String?,
      detailAddress: json['detailAddress'] as String?,
    );

Map<String, dynamic> _$CreateUserReturnRequestArgumentsToJson(
        CreateUserReturnRequestArguments instance) =>
    <String, dynamic>{
      'orderDetailId': instance.orderDetailId,
      'quantity': instance.quantity,
      'returnReason': instance.returnReason,
      'receiver': instance.receiver,
      'phone': instance.phone,
      'zipCode': instance.zipCode,
      'address': instance.address,
      'detailAddress': instance.detailAddress,
    };

CreateUserChangeRequestArguments _$CreateUserChangeRequestArgumentsFromJson(
        Map<String, dynamic> json) =>
    CreateUserChangeRequestArguments(
      orderDetailId: json['orderDetailId'] as int,
      quantity: json['quantity'] as int,
      changeReason: json['changeReason'] as String?,
      pickUpReceiver: json['pickUpReceiver'] as String?,
      pickUpPhone: json['pickUpPhone'] as String?,
      pickUpZipCode: json['pickUpZipCode'] as String?,
      pickUpAddress: json['pickUpAddress'] as String?,
      pickUpDetailAddress: json['pickUpDetailAddress'] as String?,
      deliveryReceiver: json['deliveryReceiver'] as String?,
      deliveryPhone: json['deliveryPhone'] as String?,
      deliveryZipCode: json['deliveryZipCode'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      deliveryDetailAddress: json['deliveryDetailAddress'] as String?,
      changingProductId: json['changingProductId'] as int?,
    );

Map<String, dynamic> _$CreateUserChangeRequestArgumentsToJson(
        CreateUserChangeRequestArguments instance) =>
    <String, dynamic>{
      'orderDetailId': instance.orderDetailId,
      'quantity': instance.quantity,
      'changeReason': instance.changeReason,
      'pickUpReceiver': instance.pickUpReceiver,
      'pickUpPhone': instance.pickUpPhone,
      'pickUpZipCode': instance.pickUpZipCode,
      'pickUpAddress': instance.pickUpAddress,
      'pickUpDetailAddress': instance.pickUpDetailAddress,
      'deliveryReceiver': instance.deliveryReceiver,
      'deliveryPhone': instance.deliveryPhone,
      'deliveryZipCode': instance.deliveryZipCode,
      'deliveryAddress': instance.deliveryAddress,
      'deliveryDetailAddress': instance.deliveryDetailAddress,
      'changingProductId': instance.changingProductId,
    };

ChangeDetailOfOrderDetailArguments _$ChangeDetailOfOrderDetailArgumentsFromJson(
        Map<String, dynamic> json) =>
    ChangeDetailOfOrderDetailArguments(
      orderDetailId: json['orderDetailId'] as int,
    );

Map<String, dynamic> _$ChangeDetailOfOrderDetailArgumentsToJson(
        ChangeDetailOfOrderDetailArguments instance) =>
    <String, dynamic>{
      'orderDetailId': instance.orderDetailId,
    };

ChangeOrderDeliveryArguments _$ChangeOrderDeliveryArgumentsFromJson(
        Map<String, dynamic> json) =>
    ChangeOrderDeliveryArguments(
      addressId: json['addressId'] as int?,
      orderMasterId: json['orderMasterId'] as int?,
    );

Map<String, dynamic> _$ChangeOrderDeliveryArgumentsToJson(
        ChangeOrderDeliveryArguments instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'orderMasterId': instance.orderMasterId,
    };

MyDraftsArguments _$MyDraftsArgumentsFromJson(Map<String, dynamic> json) =>
    MyDraftsArguments(
      subCategoryName: json['subCategoryName'] as String?,
    );

Map<String, dynamic> _$MyDraftsArgumentsToJson(MyDraftsArguments instance) =>
    <String, dynamic>{
      'subCategoryName': instance.subCategoryName,
    };

MyAddressesAndProductMasterArguments
    _$MyAddressesAndProductMasterArgumentsFromJson(Map<String, dynamic> json) =>
        MyAddressesAndProductMasterArguments(
          productMasterId: json['productMasterId'] as int?,
        );

Map<String, dynamic> _$MyAddressesAndProductMasterArgumentsToJson(
        MyAddressesAndProductMasterArguments instance) =>
    <String, dynamic>{
      'productMasterId': instance.productMasterId,
    };

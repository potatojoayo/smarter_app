// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:smarter/coercers.dart';
part 'graphql_api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteAddress$Mutation$DeleteAddress extends JsonSerializable
    with EquatableMixin {
  DeleteAddress$Mutation$DeleteAddress();

  factory DeleteAddress$Mutation$DeleteAddress.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteAddress$Mutation$DeleteAddressFromJson(json);

  bool? success;

  String? message;

  @override
  List<Object?> get props => [success, message];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteAddress$Mutation$DeleteAddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteAddress$Mutation extends JsonSerializable with EquatableMixin {
  DeleteAddress$Mutation();

  factory DeleteAddress$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteAddress$MutationFromJson(json);

  DeleteAddress$Mutation$DeleteAddress? deleteAddress;

  @override
  List<Object?> get props => [deleteAddress];
  @override
  Map<String, dynamic> toJson() => _$DeleteAddress$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyType
    extends JsonSerializable with EquatableMixin {
  VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyType();

  factory VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyType.fromJson(
          Map<String, dynamic> json) =>
      _$VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyTypeFromJson(
          json);

  late String name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() =>
      _$VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyTypeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class VerifyToken$Mutation$VerifyToken$UserType$GymType extends JsonSerializable
    with EquatableMixin {
  VerifyToken$Mutation$VerifyToken$UserType$GymType();

  factory VerifyToken$Mutation$VerifyToken$UserType$GymType.fromJson(
          Map<String, dynamic> json) =>
      _$VerifyToken$Mutation$VerifyToken$UserType$GymTypeFromJson(json);

  late String name;

  String? address;

  String? detailAddress;

  String? zipCode;

  String? email;

  String? businessRegistrationNumber;

  String? businessRegistrationCertificate;

  VerifyToken$Mutation$VerifyToken$UserType$GymType$AgencyType? agency;

  @override
  List<Object?> get props => [
        name,
        address,
        detailAddress,
        zipCode,
        email,
        businessRegistrationNumber,
        businessRegistrationCertificate,
        agency
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$VerifyToken$Mutation$VerifyToken$UserType$GymTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VerifyToken$Mutation$VerifyToken$UserType extends JsonSerializable
    with EquatableMixin {
  VerifyToken$Mutation$VerifyToken$UserType();

  factory VerifyToken$Mutation$VerifyToken$UserType.fromJson(
          Map<String, dynamic> json) =>
      _$VerifyToken$Mutation$VerifyToken$UserTypeFromJson(json);

  late String id;

  late String identification;

  late String name;

  late String phone;

  VerifyToken$Mutation$VerifyToken$UserType$GymType? gym;

  @override
  List<Object?> get props => [id, identification, name, phone, gym];
  @override
  Map<String, dynamic> toJson() =>
      _$VerifyToken$Mutation$VerifyToken$UserTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VerifyToken$Mutation$VerifyToken extends JsonSerializable
    with EquatableMixin {
  VerifyToken$Mutation$VerifyToken();

  factory VerifyToken$Mutation$VerifyToken.fromJson(
          Map<String, dynamic> json) =>
      _$VerifyToken$Mutation$VerifyTokenFromJson(json);

  bool? isActive;

  VerifyToken$Mutation$VerifyToken$UserType? user;

  @override
  List<Object?> get props => [isActive, user];
  @override
  Map<String, dynamic> toJson() =>
      _$VerifyToken$Mutation$VerifyTokenToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VerifyToken$Mutation extends JsonSerializable with EquatableMixin {
  VerifyToken$Mutation();

  factory VerifyToken$Mutation.fromJson(Map<String, dynamic> json) =>
      _$VerifyToken$MutationFromJson(json);

  VerifyToken$Mutation$VerifyToken? verifyToken;

  @override
  List<Object?> get props => [verifyToken];
  @override
  Map<String, dynamic> toJson() => _$VerifyToken$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query$AddressType extends JsonSerializable
    with EquatableMixin {
  OrderMasterAndAddresses$Query$AddressType();

  factory OrderMasterAndAddresses$Query$AddressType.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$Query$AddressTypeFromJson(json);

  late String id;

  late String name;

  late String receiver;

  late String phone;

  String? zipCode;

  late String address;

  String? detailAddress;

  @JsonKey(name: 'default')
  late bool kw$default;

  @override
  List<Object?> get props =>
      [id, name, receiver, phone, zipCode, address, detailAddress, kw$default];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddresses$Query$AddressTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query$CouponType$CouponMasterType
    extends JsonSerializable with EquatableMixin {
  OrderMasterAndAddresses$Query$CouponType$CouponMasterType();

  factory OrderMasterAndAddresses$Query$CouponType$CouponMasterType.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$Query$CouponType$CouponMasterTypeFromJson(json);

  String? name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddresses$Query$CouponType$CouponMasterTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query$CouponType extends JsonSerializable
    with EquatableMixin {
  OrderMasterAndAddresses$Query$CouponType();

  factory OrderMasterAndAddresses$Query$CouponType.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$Query$CouponTypeFromJson(json);

  late String id;

  late OrderMasterAndAddresses$Query$CouponType$CouponMasterType couponMaster;

  int? price;

  @JsonKey(
      fromJson: fromGraphQLDateTimeNullableToDartDateTimeNullable,
      toJson: fromDartDateTimeNullableToGraphQLDateTimeNullable)
  DateTime? startOfUse;

  @JsonKey(
      fromJson: fromGraphQLDateTimeNullableToDartDateTimeNullable,
      toJson: fromDartDateTimeNullableToGraphQLDateTimeNullable)
  DateTime? endOfUse;

  @JsonKey(
      fromJson: fromGraphQLDateTimeNullableToDartDateTimeNullable,
      toJson: fromDartDateTimeNullableToGraphQLDateTimeNullable)
  DateTime? dateUsed;

  @override
  List<Object?> get props =>
      [id, couponMaster, price, startOfUse, endOfUse, dateUsed];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddresses$Query$CouponTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandType
    extends JsonSerializable with EquatableMixin {
  OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandType();

  factory OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandType.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandTypeFromJson(
          json);

  late String name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandTypeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType
    extends JsonSerializable with EquatableMixin {
  OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType();

  factory OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryTypeFromJson(
          json);

  late String name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryTypeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode
    extends JsonSerializable with EquatableMixin {
  OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode();

  factory OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNodeFromJson(
          json);

  late String name;

  String? thumbnail;

  late OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$BrandType
      brand;

  late OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType
      category;

  late OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode$CategoryType
      subCategory;

  @override
  List<Object?> get props => [name, thumbnail, brand, category, subCategory];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNodeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode
    extends JsonSerializable with EquatableMixin {
  OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode();

  factory OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNodeFromJson(
          json);

  late String color;

  late String size;

  late OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode$ProductMasterNode
      productMaster;

  late String name;

  @override
  List<Object?> get props => [color, size, productMaster, name];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNodeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType
    extends JsonSerializable with EquatableMixin {
  OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType();

  factory OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailTypeFromJson(
          json);

  late String state;

  late OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType$ProductNode
      product;

  late int quantity;

  late int priceTotal;

  late int priceProducts;

  late int priceWork;

  late int priceWorkLabor;

  late int priceOption;

  @override
  List<Object?> get props => [
        state,
        product,
        quantity,
        priceTotal,
        priceProducts,
        priceWork,
        priceWorkLabor,
        priceOption
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailTypeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query$OrderMasterType extends JsonSerializable
    with EquatableMixin {
  OrderMasterAndAddresses$Query$OrderMasterType();

  factory OrderMasterAndAddresses$Query$OrderMasterType.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$Query$OrderMasterTypeFromJson(json);

  late String id;

  late String orderNumber;

  late int priceDelivery;

  int? priceTotalProducts;

  int? priceToPay;

  String? orderName;

  late String receiver;

  late String address;

  String? detailAddress;

  String? zipCode;

  late String phone;

  List<OrderMasterAndAddresses$Query$OrderMasterType$OrderDetailType?>? details;

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        priceDelivery,
        priceTotalProducts,
        priceToPay,
        orderName,
        receiver,
        address,
        detailAddress,
        zipCode,
        phone,
        details
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddresses$Query$OrderMasterTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddresses$Query extends JsonSerializable
    with EquatableMixin {
  OrderMasterAndAddresses$Query();

  factory OrderMasterAndAddresses$Query.fromJson(Map<String, dynamic> json) =>
      _$OrderMasterAndAddresses$QueryFromJson(json);

  List<OrderMasterAndAddresses$Query$AddressType?>? myAddresses;

  bool? didUseCouponToday;

  List<OrderMasterAndAddresses$Query$CouponType?>? myCoupons;

  OrderMasterAndAddresses$Query$OrderMasterType? orderMaster;

  @override
  List<Object?> get props =>
      [myAddresses, didUseCouponToday, myCoupons, orderMaster];
  @override
  Map<String, dynamic> toJson() => _$OrderMasterAndAddresses$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyCoupons$Query$CouponType$CouponMasterType extends JsonSerializable
    with EquatableMixin {
  MyCoupons$Query$CouponType$CouponMasterType();

  factory MyCoupons$Query$CouponType$CouponMasterType.fromJson(
          Map<String, dynamic> json) =>
      _$MyCoupons$Query$CouponType$CouponMasterTypeFromJson(json);

  String? name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() =>
      _$MyCoupons$Query$CouponType$CouponMasterTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyCoupons$Query$CouponType extends JsonSerializable with EquatableMixin {
  MyCoupons$Query$CouponType();

  factory MyCoupons$Query$CouponType.fromJson(Map<String, dynamic> json) =>
      _$MyCoupons$Query$CouponTypeFromJson(json);

  late String id;

  late MyCoupons$Query$CouponType$CouponMasterType couponMaster;

  int? price;

  @JsonKey(
      fromJson: fromGraphQLDateTimeNullableToDartDateTimeNullable,
      toJson: fromDartDateTimeNullableToGraphQLDateTimeNullable)
  DateTime? startOfUse;

  @JsonKey(
      fromJson: fromGraphQLDateTimeNullableToDartDateTimeNullable,
      toJson: fromDartDateTimeNullableToGraphQLDateTimeNullable)
  DateTime? endOfUse;

  @JsonKey(
      fromJson: fromGraphQLDateTimeNullableToDartDateTimeNullable,
      toJson: fromDartDateTimeNullableToGraphQLDateTimeNullable)
  DateTime? dateUsed;

  @override
  List<Object?> get props =>
      [id, couponMaster, price, startOfUse, endOfUse, dateUsed];
  @override
  Map<String, dynamic> toJson() => _$MyCoupons$Query$CouponTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyCoupons$Query extends JsonSerializable with EquatableMixin {
  MyCoupons$Query();

  factory MyCoupons$Query.fromJson(Map<String, dynamic> json) =>
      _$MyCoupons$QueryFromJson(json);

  List<MyCoupons$Query$CouponType?>? myCoupons;

  @override
  List<Object?> get props => [myCoupons];
  @override
  Map<String, dynamic> toJson() => _$MyCoupons$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterType
    extends JsonSerializable with EquatableMixin {
  OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterType();

  factory OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterType.fromJson(
          Map<String, dynamic> json) =>
      _$OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterTypeFromJson(
          json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterTypeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class OrderBySmarterMoney$Mutation$OrderBySmarterMoney extends JsonSerializable
    with EquatableMixin {
  OrderBySmarterMoney$Mutation$OrderBySmarterMoney();

  factory OrderBySmarterMoney$Mutation$OrderBySmarterMoney.fromJson(
          Map<String, dynamic> json) =>
      _$OrderBySmarterMoney$Mutation$OrderBySmarterMoneyFromJson(json);

  bool? success;

  OrderBySmarterMoney$Mutation$OrderBySmarterMoney$OrderMasterType? orderMaster;

  @override
  List<Object?> get props => [success, orderMaster];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderBySmarterMoney$Mutation$OrderBySmarterMoneyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderBySmarterMoney$Mutation extends JsonSerializable
    with EquatableMixin {
  OrderBySmarterMoney$Mutation();

  factory OrderBySmarterMoney$Mutation.fromJson(Map<String, dynamic> json) =>
      _$OrderBySmarterMoney$MutationFromJson(json);

  OrderBySmarterMoney$Mutation$OrderBySmarterMoney? orderBySmarterMoney;

  @override
  List<Object?> get props => [orderBySmarterMoney];
  @override
  Map<String, dynamic> toJson() => _$OrderBySmarterMoney$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CancelOrder$Mutation$UserCancelOrder extends JsonSerializable
    with EquatableMixin {
  CancelOrder$Mutation$UserCancelOrder();

  factory CancelOrder$Mutation$UserCancelOrder.fromJson(
          Map<String, dynamic> json) =>
      _$CancelOrder$Mutation$UserCancelOrderFromJson(json);

  late bool success;

  late String message;

  @override
  List<Object?> get props => [success, message];
  @override
  Map<String, dynamic> toJson() =>
      _$CancelOrder$Mutation$UserCancelOrderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CancelOrder$Mutation extends JsonSerializable with EquatableMixin {
  CancelOrder$Mutation();

  factory CancelOrder$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CancelOrder$MutationFromJson(json);

  CancelOrder$Mutation$UserCancelOrder? userCancelOrder;

  @override
  List<Object?> get props => [userCancelOrder];
  @override
  Map<String, dynamic> toJson() => _$CancelOrder$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUserReturnRequest$Mutation$CreateUserReturnRequest
    extends JsonSerializable with EquatableMixin {
  CreateUserReturnRequest$Mutation$CreateUserReturnRequest();

  factory CreateUserReturnRequest$Mutation$CreateUserReturnRequest.fromJson(
          Map<String, dynamic> json) =>
      _$CreateUserReturnRequest$Mutation$CreateUserReturnRequestFromJson(json);

  bool? success;

  String? message;

  @override
  List<Object?> get props => [success, message];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateUserReturnRequest$Mutation$CreateUserReturnRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUserReturnRequest$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateUserReturnRequest$Mutation();

  factory CreateUserReturnRequest$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$CreateUserReturnRequest$MutationFromJson(json);

  CreateUserReturnRequest$Mutation$CreateUserReturnRequest?
      createUserReturnRequest;

  @override
  List<Object?> get props => [createUserReturnRequest];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateUserReturnRequest$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUserChangeRequest$Mutation$CreateUserChangeRequest
    extends JsonSerializable with EquatableMixin {
  CreateUserChangeRequest$Mutation$CreateUserChangeRequest();

  factory CreateUserChangeRequest$Mutation$CreateUserChangeRequest.fromJson(
          Map<String, dynamic> json) =>
      _$CreateUserChangeRequest$Mutation$CreateUserChangeRequestFromJson(json);

  bool? success;

  String? message;

  @override
  List<Object?> get props => [success, message];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateUserChangeRequest$Mutation$CreateUserChangeRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUserChangeRequest$Mutation extends JsonSerializable
    with EquatableMixin {
  CreateUserChangeRequest$Mutation();

  factory CreateUserChangeRequest$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$CreateUserChangeRequest$MutationFromJson(json);

  CreateUserChangeRequest$Mutation$CreateUserChangeRequest?
      createUserChangeRequest;

  @override
  List<Object?> get props => [createUserChangeRequest];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateUserChangeRequest$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductType
    extends JsonSerializable with EquatableMixin {
  ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductType();

  factory ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductType.fromJson(
          Map<String, dynamic> json) =>
      _$ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductTypeFromJson(
          json);

  late String color;

  late String size;

  late int priceAdditional;

  @override
  List<Object?> get props => [color, size, priceAdditional];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductTypeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class ChangeDetailOfOrderDetail$Query$ChangeDetailType extends JsonSerializable
    with EquatableMixin {
  ChangeDetailOfOrderDetail$Query$ChangeDetailType();

  factory ChangeDetailOfOrderDetail$Query$ChangeDetailType.fromJson(
          Map<String, dynamic> json) =>
      _$ChangeDetailOfOrderDetail$Query$ChangeDetailTypeFromJson(json);

  int? changingQuantity;

  ChangeDetailOfOrderDetail$Query$ChangeDetailType$ProductType? changingProduct;

  @override
  List<Object?> get props => [changingQuantity, changingProduct];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangeDetailOfOrderDetail$Query$ChangeDetailTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChangeDetailOfOrderDetail$Query extends JsonSerializable
    with EquatableMixin {
  ChangeDetailOfOrderDetail$Query();

  factory ChangeDetailOfOrderDetail$Query.fromJson(Map<String, dynamic> json) =>
      _$ChangeDetailOfOrderDetail$QueryFromJson(json);

  ChangeDetailOfOrderDetail$Query$ChangeDetailType? changeDetailOfOrderDetail;

  @override
  List<Object?> get props => [changeDetailOfOrderDetail];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangeDetailOfOrderDetail$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChangeOrderDelivery$Mutation$ChangeOrderDelivery extends JsonSerializable
    with EquatableMixin {
  ChangeOrderDelivery$Mutation$ChangeOrderDelivery();

  factory ChangeOrderDelivery$Mutation$ChangeOrderDelivery.fromJson(
          Map<String, dynamic> json) =>
      _$ChangeOrderDelivery$Mutation$ChangeOrderDeliveryFromJson(json);

  bool? success;

  @override
  List<Object?> get props => [success];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangeOrderDelivery$Mutation$ChangeOrderDeliveryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChangeOrderDelivery$Mutation extends JsonSerializable
    with EquatableMixin {
  ChangeOrderDelivery$Mutation();

  factory ChangeOrderDelivery$Mutation.fromJson(Map<String, dynamic> json) =>
      _$ChangeOrderDelivery$MutationFromJson(json);

  ChangeOrderDelivery$Mutation$ChangeOrderDelivery? changeOrderDelivery;

  @override
  List<Object?> get props => [changeOrderDelivery];
  @override
  Map<String, dynamic> toJson() => _$ChangeOrderDelivery$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyDrafts$Query$NewDraftType extends JsonSerializable with EquatableMixin {
  MyDrafts$Query$NewDraftType();

  factory MyDrafts$Query$NewDraftType.fromJson(Map<String, dynamic> json) =>
      _$MyDrafts$Query$NewDraftTypeFromJson(json);

  late String id;

  String? categoryName;

  String? subCategoryName;

  String? image;

  String? printing;

  int? priceWork;

  String? font;

  String? threadColor;

  @override
  List<Object?> get props => [
        id,
        categoryName,
        subCategoryName,
        image,
        printing,
        priceWork,
        font,
        threadColor
      ];
  @override
  Map<String, dynamic> toJson() => _$MyDrafts$Query$NewDraftTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyDrafts$Query extends JsonSerializable with EquatableMixin {
  MyDrafts$Query();

  factory MyDrafts$Query.fromJson(Map<String, dynamic> json) =>
      _$MyDrafts$QueryFromJson(json);

  List<MyDrafts$Query$NewDraftType?>? myDrafts;

  @override
  List<Object?> get props => [myDrafts];
  @override
  Map<String, dynamic> toJson() => _$MyDrafts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyAddressesAndProductMaster$Query$ProductMasterType$ProductType
    extends JsonSerializable with EquatableMixin {
  MyAddressesAndProductMaster$Query$ProductMasterType$ProductType();

  factory MyAddressesAndProductMaster$Query$ProductMasterType$ProductType.fromJson(
          Map<String, dynamic> json) =>
      _$MyAddressesAndProductMaster$Query$ProductMasterType$ProductTypeFromJson(
          json);

  int? productId;

  late int priceAdditional;

  late String color;

  late String size;

  @override
  List<Object?> get props => [productId, priceAdditional, color, size];
  @override
  Map<String, dynamic> toJson() =>
      _$MyAddressesAndProductMaster$Query$ProductMasterType$ProductTypeToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class MyAddressesAndProductMaster$Query$ProductMasterType
    extends JsonSerializable with EquatableMixin {
  MyAddressesAndProductMaster$Query$ProductMasterType();

  factory MyAddressesAndProductMaster$Query$ProductMasterType.fromJson(
          Map<String, dynamic> json) =>
      _$MyAddressesAndProductMaster$Query$ProductMasterTypeFromJson(json);

  List<String?>? sizes;

  List<String?>? colors;

  List<MyAddressesAndProductMaster$Query$ProductMasterType$ProductType?>?
      products;

  @override
  List<Object?> get props => [sizes, colors, products];
  @override
  Map<String, dynamic> toJson() =>
      _$MyAddressesAndProductMaster$Query$ProductMasterTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyAddressesAndProductMaster$Query$AddressType extends JsonSerializable
    with EquatableMixin {
  MyAddressesAndProductMaster$Query$AddressType();

  factory MyAddressesAndProductMaster$Query$AddressType.fromJson(
          Map<String, dynamic> json) =>
      _$MyAddressesAndProductMaster$Query$AddressTypeFromJson(json);

  late String id;

  late String name;

  late String receiver;

  late String phone;

  String? zipCode;

  late String address;

  String? detailAddress;

  @JsonKey(name: 'default')
  late bool kw$default;

  @override
  List<Object?> get props =>
      [id, name, receiver, phone, zipCode, address, detailAddress, kw$default];
  @override
  Map<String, dynamic> toJson() =>
      _$MyAddressesAndProductMaster$Query$AddressTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyAddressesAndProductMaster$Query extends JsonSerializable
    with EquatableMixin {
  MyAddressesAndProductMaster$Query();

  factory MyAddressesAndProductMaster$Query.fromJson(
          Map<String, dynamic> json) =>
      _$MyAddressesAndProductMaster$QueryFromJson(json);

  MyAddressesAndProductMaster$Query$ProductMasterType? productMaster;

  List<MyAddressesAndProductMaster$Query$AddressType?>? myAddresses;

  @override
  List<Object?> get props => [productMaster, myAddresses];
  @override
  Map<String, dynamic> toJson() =>
      _$MyAddressesAndProductMaster$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteAddressArguments extends JsonSerializable with EquatableMixin {
  DeleteAddressArguments({required this.addressId});

  @override
  factory DeleteAddressArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteAddressArgumentsFromJson(json);

  late int addressId;

  @override
  List<Object?> get props => [addressId];
  @override
  Map<String, dynamic> toJson() => _$DeleteAddressArgumentsToJson(this);
}

final DELETE_ADDRESS_MUTATION_DOCUMENT_OPERATION_NAME = 'DeleteAddress';
final DELETE_ADDRESS_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'DeleteAddress'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'addressId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'deleteAddress'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'addressId'),
            value: VariableNode(name: NameNode(value: 'addressId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'success'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      )
    ]),
  )
]);

class DeleteAddressMutation
    extends GraphQLQuery<DeleteAddress$Mutation, DeleteAddressArguments> {
  DeleteAddressMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_ADDRESS_MUTATION_DOCUMENT;

  @override
  final String operationName = DELETE_ADDRESS_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final DeleteAddressArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteAddress$Mutation parse(Map<String, dynamic> json) =>
      DeleteAddress$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class VerifyTokenArguments extends JsonSerializable with EquatableMixin {
  VerifyTokenArguments({
    this.token,
    this.fcmToken,
  });

  @override
  factory VerifyTokenArguments.fromJson(Map<String, dynamic> json) =>
      _$VerifyTokenArgumentsFromJson(json);

  final String? token;

  final String? fcmToken;

  @override
  List<Object?> get props => [token, fcmToken];
  @override
  Map<String, dynamic> toJson() => _$VerifyTokenArgumentsToJson(this);
}

final VERIFY_TOKEN_MUTATION_DOCUMENT_OPERATION_NAME = 'VerifyToken';
final VERIFY_TOKEN_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'VerifyToken'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'token')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'fcmToken')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'verifyToken'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'token'),
            value: VariableNode(name: NameNode(value: 'token')),
          ),
          ArgumentNode(
            name: NameNode(value: 'fcmToken'),
            value: VariableNode(name: NameNode(value: 'fcmToken')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'isActive'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'identification'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'phone'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'gym'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'address'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'detailAddress'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'zipCode'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'email'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'businessRegistrationNumber'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'businessRegistrationCertificate'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'agency'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      )
                    ]),
                  ),
                ]),
              ),
            ]),
          ),
        ]),
      )
    ]),
  )
]);

class VerifyTokenMutation
    extends GraphQLQuery<VerifyToken$Mutation, VerifyTokenArguments> {
  VerifyTokenMutation({required this.variables});

  @override
  final DocumentNode document = VERIFY_TOKEN_MUTATION_DOCUMENT;

  @override
  final String operationName = VERIFY_TOKEN_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final VerifyTokenArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  VerifyToken$Mutation parse(Map<String, dynamic> json) =>
      VerifyToken$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class OrderMasterAndAddressesArguments extends JsonSerializable
    with EquatableMixin {
  OrderMasterAndAddressesArguments({required this.orderMasterId});

  @override
  factory OrderMasterAndAddressesArguments.fromJson(
          Map<String, dynamic> json) =>
      _$OrderMasterAndAddressesArgumentsFromJson(json);

  late int orderMasterId;

  @override
  List<Object?> get props => [orderMasterId];
  @override
  Map<String, dynamic> toJson() =>
      _$OrderMasterAndAddressesArgumentsToJson(this);
}

final ORDER_MASTER_AND_ADDRESSES_QUERY_DOCUMENT_OPERATION_NAME =
    'OrderMasterAndAddresses';
final ORDER_MASTER_AND_ADDRESSES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'OrderMasterAndAddresses'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orderMasterId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'myAddresses'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'receiver'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'phone'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'zipCode'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'address'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'detailAddress'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'default'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: 'didUseCouponToday'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'myCoupons'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'couponMaster'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              )
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'price'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'startOfUse'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'endOfUse'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'dateUsed'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: 'orderMaster'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'orderMasterId'),
            value: VariableNode(name: NameNode(value: 'orderMasterId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'orderNumber'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'priceDelivery'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'priceTotalProducts'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'priceToPay'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'orderName'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'receiver'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'address'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'detailAddress'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'zipCode'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'phone'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'details'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'state'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'product'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'color'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'size'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'productMaster'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'thumbnail'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'brand'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                            name: NameNode(value: 'name'),
                            alias: null,
                            arguments: [],
                            directives: [],
                            selectionSet: null,
                          )
                        ]),
                      ),
                      FieldNode(
                        name: NameNode(value: 'category'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                            name: NameNode(value: 'name'),
                            alias: null,
                            arguments: [],
                            directives: [],
                            selectionSet: null,
                          )
                        ]),
                      ),
                      FieldNode(
                        name: NameNode(value: 'subCategory'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                            name: NameNode(value: 'name'),
                            alias: null,
                            arguments: [],
                            directives: [],
                            selectionSet: null,
                          )
                        ]),
                      ),
                    ]),
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: 'quantity'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'priceTotal'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'priceProducts'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'priceWork'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'priceWorkLabor'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'priceOption'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
        ]),
      ),
    ]),
  )
]);

class OrderMasterAndAddressesQuery extends GraphQLQuery<
    OrderMasterAndAddresses$Query, OrderMasterAndAddressesArguments> {
  OrderMasterAndAddressesQuery({required this.variables});

  @override
  final DocumentNode document = ORDER_MASTER_AND_ADDRESSES_QUERY_DOCUMENT;

  @override
  final String operationName =
      ORDER_MASTER_AND_ADDRESSES_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final OrderMasterAndAddressesArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  OrderMasterAndAddresses$Query parse(Map<String, dynamic> json) =>
      OrderMasterAndAddresses$Query.fromJson(json);
}

final MY_COUPONS_QUERY_DOCUMENT_OPERATION_NAME = 'MyCoupons';
final MY_COUPONS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'MyCoupons'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'myCoupons'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'couponMaster'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              )
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'price'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'startOfUse'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'endOfUse'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'dateUsed'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      )
    ]),
  )
]);

class MyCouponsQuery extends GraphQLQuery<MyCoupons$Query, JsonSerializable> {
  MyCouponsQuery();

  @override
  final DocumentNode document = MY_COUPONS_QUERY_DOCUMENT;

  @override
  final String operationName = MY_COUPONS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  MyCoupons$Query parse(Map<String, dynamic> json) =>
      MyCoupons$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class OrderBySmarterMoneyArguments extends JsonSerializable
    with EquatableMixin {
  OrderBySmarterMoneyArguments({
    required this.orderMasterId,
    required this.receiver,
    required this.phone,
    required this.zipCode,
    required this.address,
    this.detailAddress,
    this.deliveryRequest,
    required this.smarterMoney,
    this.couponId,
  });

  @override
  factory OrderBySmarterMoneyArguments.fromJson(Map<String, dynamic> json) =>
      _$OrderBySmarterMoneyArgumentsFromJson(json);

  late int orderMasterId;

  late String receiver;

  late String phone;

  late String zipCode;

  late String address;

  final String? detailAddress;

  final String? deliveryRequest;

  late int smarterMoney;

  final int? couponId;

  @override
  List<Object?> get props => [
        orderMasterId,
        receiver,
        phone,
        zipCode,
        address,
        detailAddress,
        deliveryRequest,
        smarterMoney,
        couponId
      ];
  @override
  Map<String, dynamic> toJson() => _$OrderBySmarterMoneyArgumentsToJson(this);
}

final ORDER_BY_SMARTER_MONEY_MUTATION_DOCUMENT_OPERATION_NAME =
    'OrderBySmarterMoney';
final ORDER_BY_SMARTER_MONEY_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'OrderBySmarterMoney'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orderMasterId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'receiver')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'phone')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'zipCode')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'address')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'detailAddress')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'deliveryRequest')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'smarterMoney')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'couponId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'orderBySmarterMoney'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'orderMasterId'),
            value: VariableNode(name: NameNode(value: 'orderMasterId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'receiver'),
            value: VariableNode(name: NameNode(value: 'receiver')),
          ),
          ArgumentNode(
            name: NameNode(value: 'phone'),
            value: VariableNode(name: NameNode(value: 'phone')),
          ),
          ArgumentNode(
            name: NameNode(value: 'zipCode'),
            value: VariableNode(name: NameNode(value: 'zipCode')),
          ),
          ArgumentNode(
            name: NameNode(value: 'address'),
            value: VariableNode(name: NameNode(value: 'address')),
          ),
          ArgumentNode(
            name: NameNode(value: 'detailAddress'),
            value: VariableNode(name: NameNode(value: 'detailAddress')),
          ),
          ArgumentNode(
            name: NameNode(value: 'smarterMoney'),
            value: VariableNode(name: NameNode(value: 'smarterMoney')),
          ),
          ArgumentNode(
            name: NameNode(value: 'deliveryRequest'),
            value: VariableNode(name: NameNode(value: 'deliveryRequest')),
          ),
          ArgumentNode(
            name: NameNode(value: 'couponId'),
            value: VariableNode(name: NameNode(value: 'couponId')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'success'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'orderMaster'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              )
            ]),
          ),
        ]),
      )
    ]),
  )
]);

class OrderBySmarterMoneyMutation extends GraphQLQuery<
    OrderBySmarterMoney$Mutation, OrderBySmarterMoneyArguments> {
  OrderBySmarterMoneyMutation({required this.variables});

  @override
  final DocumentNode document = ORDER_BY_SMARTER_MONEY_MUTATION_DOCUMENT;

  @override
  final String operationName =
      ORDER_BY_SMARTER_MONEY_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final OrderBySmarterMoneyArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  OrderBySmarterMoney$Mutation parse(Map<String, dynamic> json) =>
      OrderBySmarterMoney$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CancelOrderArguments extends JsonSerializable with EquatableMixin {
  CancelOrderArguments({required this.orderMasterId});

  @override
  factory CancelOrderArguments.fromJson(Map<String, dynamic> json) =>
      _$CancelOrderArgumentsFromJson(json);

  late int orderMasterId;

  @override
  List<Object?> get props => [orderMasterId];
  @override
  Map<String, dynamic> toJson() => _$CancelOrderArgumentsToJson(this);
}

final CANCEL_ORDER_MUTATION_DOCUMENT_OPERATION_NAME = 'CancelOrder';
final CANCEL_ORDER_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CancelOrder'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orderMasterId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'userCancelOrder'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'orderMasterId'),
            value: VariableNode(name: NameNode(value: 'orderMasterId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'success'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      )
    ]),
  )
]);

class CancelOrderMutation
    extends GraphQLQuery<CancelOrder$Mutation, CancelOrderArguments> {
  CancelOrderMutation({required this.variables});

  @override
  final DocumentNode document = CANCEL_ORDER_MUTATION_DOCUMENT;

  @override
  final String operationName = CANCEL_ORDER_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final CancelOrderArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CancelOrder$Mutation parse(Map<String, dynamic> json) =>
      CancelOrder$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateUserReturnRequestArguments extends JsonSerializable
    with EquatableMixin {
  CreateUserReturnRequestArguments({
    required this.orderDetailId,
    required this.quantity,
    this.returnReason,
    this.receiver,
    this.phone,
    this.zipCode,
    this.address,
    this.detailAddress,
  });

  @override
  factory CreateUserReturnRequestArguments.fromJson(
          Map<String, dynamic> json) =>
      _$CreateUserReturnRequestArgumentsFromJson(json);

  late int orderDetailId;

  late int quantity;

  final String? returnReason;

  final String? receiver;

  final String? phone;

  final String? zipCode;

  final String? address;

  final String? detailAddress;

  @override
  List<Object?> get props => [
        orderDetailId,
        quantity,
        returnReason,
        receiver,
        phone,
        zipCode,
        address,
        detailAddress
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateUserReturnRequestArgumentsToJson(this);
}

final CREATE_USER_RETURN_REQUEST_MUTATION_DOCUMENT_OPERATION_NAME =
    'CreateUserReturnRequest';
final CREATE_USER_RETURN_REQUEST_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateUserReturnRequest'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orderDetailId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'quantity')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'returnReason')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'receiver')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'phone')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'zipCode')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'address')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'detailAddress')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createUserReturnRequest'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'address'),
            value: VariableNode(name: NameNode(value: 'address')),
          ),
          ArgumentNode(
            name: NameNode(value: 'orderDetailId'),
            value: VariableNode(name: NameNode(value: 'orderDetailId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'quantity'),
            value: VariableNode(name: NameNode(value: 'quantity')),
          ),
          ArgumentNode(
            name: NameNode(value: 'detailAddress'),
            value: VariableNode(name: NameNode(value: 'detailAddress')),
          ),
          ArgumentNode(
            name: NameNode(value: 'phone'),
            value: VariableNode(name: NameNode(value: 'phone')),
          ),
          ArgumentNode(
            name: NameNode(value: 'zipCode'),
            value: VariableNode(name: NameNode(value: 'zipCode')),
          ),
          ArgumentNode(
            name: NameNode(value: 'receiver'),
            value: VariableNode(name: NameNode(value: 'receiver')),
          ),
          ArgumentNode(
            name: NameNode(value: 'returnReason'),
            value: VariableNode(name: NameNode(value: 'returnReason')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'success'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      )
    ]),
  )
]);

class CreateUserReturnRequestMutation extends GraphQLQuery<
    CreateUserReturnRequest$Mutation, CreateUserReturnRequestArguments> {
  CreateUserReturnRequestMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_USER_RETURN_REQUEST_MUTATION_DOCUMENT;

  @override
  final String operationName =
      CREATE_USER_RETURN_REQUEST_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final CreateUserReturnRequestArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateUserReturnRequest$Mutation parse(Map<String, dynamic> json) =>
      CreateUserReturnRequest$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateUserChangeRequestArguments extends JsonSerializable
    with EquatableMixin {
  CreateUserChangeRequestArguments({
    required this.orderDetailId,
    required this.quantity,
    this.changeReason,
    this.pickUpReceiver,
    this.pickUpPhone,
    this.pickUpZipCode,
    this.pickUpAddress,
    this.pickUpDetailAddress,
    this.deliveryReceiver,
    this.deliveryPhone,
    this.deliveryZipCode,
    this.deliveryAddress,
    this.deliveryDetailAddress,
    this.changingProductId,
  });

  @override
  factory CreateUserChangeRequestArguments.fromJson(
          Map<String, dynamic> json) =>
      _$CreateUserChangeRequestArgumentsFromJson(json);

  late int orderDetailId;

  late int quantity;

  final String? changeReason;

  final String? pickUpReceiver;

  final String? pickUpPhone;

  final String? pickUpZipCode;

  final String? pickUpAddress;

  final String? pickUpDetailAddress;

  final String? deliveryReceiver;

  final String? deliveryPhone;

  final String? deliveryZipCode;

  final String? deliveryAddress;

  final String? deliveryDetailAddress;

  final int? changingProductId;

  @override
  List<Object?> get props => [
        orderDetailId,
        quantity,
        changeReason,
        pickUpReceiver,
        pickUpPhone,
        pickUpZipCode,
        pickUpAddress,
        pickUpDetailAddress,
        deliveryReceiver,
        deliveryPhone,
        deliveryZipCode,
        deliveryAddress,
        deliveryDetailAddress,
        changingProductId
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateUserChangeRequestArgumentsToJson(this);
}

final CREATE_USER_CHANGE_REQUEST_MUTATION_DOCUMENT_OPERATION_NAME =
    'CreateUserChangeRequest';
final CREATE_USER_CHANGE_REQUEST_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateUserChangeRequest'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orderDetailId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'quantity')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'changeReason')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'pickUpReceiver')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'pickUpPhone')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'pickUpZipCode')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'pickUpAddress')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'pickUpDetailAddress')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'deliveryReceiver')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'deliveryPhone')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'deliveryZipCode')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'deliveryAddress')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'deliveryDetailAddress')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'changingProductId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createUserChangeRequest'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'orderDetailId'),
            value: VariableNode(name: NameNode(value: 'orderDetailId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'changingQuantity'),
            value: VariableNode(name: NameNode(value: 'quantity')),
          ),
          ArgumentNode(
            name: NameNode(value: 'changeReason'),
            value: VariableNode(name: NameNode(value: 'changeReason')),
          ),
          ArgumentNode(
            name: NameNode(value: 'pickUpAddress'),
            value: VariableNode(name: NameNode(value: 'pickUpAddress')),
          ),
          ArgumentNode(
            name: NameNode(value: 'pickUpReceiver'),
            value: VariableNode(name: NameNode(value: 'pickUpReceiver')),
          ),
          ArgumentNode(
            name: NameNode(value: 'pickUpPhone'),
            value: VariableNode(name: NameNode(value: 'pickUpPhone')),
          ),
          ArgumentNode(
            name: NameNode(value: 'pickUpZipCode'),
            value: VariableNode(name: NameNode(value: 'pickUpZipCode')),
          ),
          ArgumentNode(
            name: NameNode(value: 'pickUpDetailAddress'),
            value: VariableNode(name: NameNode(value: 'pickUpDetailAddress')),
          ),
          ArgumentNode(
            name: NameNode(value: 'deliveryAddress'),
            value: VariableNode(name: NameNode(value: 'deliveryAddress')),
          ),
          ArgumentNode(
            name: NameNode(value: 'deliveryReceiver'),
            value: VariableNode(name: NameNode(value: 'deliveryReceiver')),
          ),
          ArgumentNode(
            name: NameNode(value: 'deliveryPhone'),
            value: VariableNode(name: NameNode(value: 'deliveryPhone')),
          ),
          ArgumentNode(
            name: NameNode(value: 'deliveryZipCode'),
            value: VariableNode(name: NameNode(value: 'deliveryZipCode')),
          ),
          ArgumentNode(
            name: NameNode(value: 'deliveryDetailAddress'),
            value: VariableNode(name: NameNode(value: 'deliveryDetailAddress')),
          ),
          ArgumentNode(
            name: NameNode(value: 'changingProductId'),
            value: VariableNode(name: NameNode(value: 'changingProductId')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'success'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      )
    ]),
  )
]);

class CreateUserChangeRequestMutation extends GraphQLQuery<
    CreateUserChangeRequest$Mutation, CreateUserChangeRequestArguments> {
  CreateUserChangeRequestMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_USER_CHANGE_REQUEST_MUTATION_DOCUMENT;

  @override
  final String operationName =
      CREATE_USER_CHANGE_REQUEST_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final CreateUserChangeRequestArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateUserChangeRequest$Mutation parse(Map<String, dynamic> json) =>
      CreateUserChangeRequest$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ChangeDetailOfOrderDetailArguments extends JsonSerializable
    with EquatableMixin {
  ChangeDetailOfOrderDetailArguments({required this.orderDetailId});

  @override
  factory ChangeDetailOfOrderDetailArguments.fromJson(
          Map<String, dynamic> json) =>
      _$ChangeDetailOfOrderDetailArgumentsFromJson(json);

  late int orderDetailId;

  @override
  List<Object?> get props => [orderDetailId];
  @override
  Map<String, dynamic> toJson() =>
      _$ChangeDetailOfOrderDetailArgumentsToJson(this);
}

final CHANGE_DETAIL_OF_ORDER_DETAIL_QUERY_DOCUMENT_OPERATION_NAME =
    'ChangeDetailOfOrderDetail';
final CHANGE_DETAIL_OF_ORDER_DETAIL_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'ChangeDetailOfOrderDetail'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orderDetailId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'changeDetailOfOrderDetail'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'orderDetailId'),
            value: VariableNode(name: NameNode(value: 'orderDetailId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'changingQuantity'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'changingProduct'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'color'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'size'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'priceAdditional'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
        ]),
      )
    ]),
  )
]);

class ChangeDetailOfOrderDetailQuery extends GraphQLQuery<
    ChangeDetailOfOrderDetail$Query, ChangeDetailOfOrderDetailArguments> {
  ChangeDetailOfOrderDetailQuery({required this.variables});

  @override
  final DocumentNode document = CHANGE_DETAIL_OF_ORDER_DETAIL_QUERY_DOCUMENT;

  @override
  final String operationName =
      CHANGE_DETAIL_OF_ORDER_DETAIL_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final ChangeDetailOfOrderDetailArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  ChangeDetailOfOrderDetail$Query parse(Map<String, dynamic> json) =>
      ChangeDetailOfOrderDetail$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ChangeOrderDeliveryArguments extends JsonSerializable
    with EquatableMixin {
  ChangeOrderDeliveryArguments({
    this.addressId,
    this.orderMasterId,
  });

  @override
  factory ChangeOrderDeliveryArguments.fromJson(Map<String, dynamic> json) =>
      _$ChangeOrderDeliveryArgumentsFromJson(json);

  final int? addressId;

  final int? orderMasterId;

  @override
  List<Object?> get props => [addressId, orderMasterId];
  @override
  Map<String, dynamic> toJson() => _$ChangeOrderDeliveryArgumentsToJson(this);
}

final CHANGE_ORDER_DELIVERY_MUTATION_DOCUMENT_OPERATION_NAME =
    'ChangeOrderDelivery';
final CHANGE_ORDER_DELIVERY_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ChangeOrderDelivery'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'addressId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'orderMasterId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'changeOrderDelivery'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'addressId'),
            value: VariableNode(name: NameNode(value: 'addressId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'orderMasterId'),
            value: VariableNode(name: NameNode(value: 'orderMasterId')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'success'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          )
        ]),
      )
    ]),
  )
]);

class ChangeOrderDeliveryMutation extends GraphQLQuery<
    ChangeOrderDelivery$Mutation, ChangeOrderDeliveryArguments> {
  ChangeOrderDeliveryMutation({required this.variables});

  @override
  final DocumentNode document = CHANGE_ORDER_DELIVERY_MUTATION_DOCUMENT;

  @override
  final String operationName =
      CHANGE_ORDER_DELIVERY_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final ChangeOrderDeliveryArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  ChangeOrderDelivery$Mutation parse(Map<String, dynamic> json) =>
      ChangeOrderDelivery$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class MyDraftsArguments extends JsonSerializable with EquatableMixin {
  MyDraftsArguments({this.subCategoryName});

  @override
  factory MyDraftsArguments.fromJson(Map<String, dynamic> json) =>
      _$MyDraftsArgumentsFromJson(json);

  final String? subCategoryName;

  @override
  List<Object?> get props => [subCategoryName];
  @override
  Map<String, dynamic> toJson() => _$MyDraftsArgumentsToJson(this);
}

final MY_DRAFTS_QUERY_DOCUMENT_OPERATION_NAME = 'MyDrafts';
final MY_DRAFTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'MyDrafts'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'subCategoryName')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'myDrafts'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'subCategoryName'),
            value: VariableNode(name: NameNode(value: 'subCategoryName')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'categoryName'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'subCategoryName'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'image'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'printing'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'priceWork'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'font'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'threadColor'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      )
    ]),
  )
]);

class MyDraftsQuery extends GraphQLQuery<MyDrafts$Query, MyDraftsArguments> {
  MyDraftsQuery({required this.variables});

  @override
  final DocumentNode document = MY_DRAFTS_QUERY_DOCUMENT;

  @override
  final String operationName = MY_DRAFTS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final MyDraftsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  MyDrafts$Query parse(Map<String, dynamic> json) =>
      MyDrafts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class MyAddressesAndProductMasterArguments extends JsonSerializable
    with EquatableMixin {
  MyAddressesAndProductMasterArguments({this.productMasterId});

  @override
  factory MyAddressesAndProductMasterArguments.fromJson(
          Map<String, dynamic> json) =>
      _$MyAddressesAndProductMasterArgumentsFromJson(json);

  final int? productMasterId;

  @override
  List<Object?> get props => [productMasterId];
  @override
  Map<String, dynamic> toJson() =>
      _$MyAddressesAndProductMasterArgumentsToJson(this);
}

final MY_ADDRESSES_AND_PRODUCT_MASTER_QUERY_DOCUMENT_OPERATION_NAME =
    'MyAddressesAndProductMaster';
final MY_ADDRESSES_AND_PRODUCT_MASTER_QUERY_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'MyAddressesAndProductMaster'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'productMasterId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'productMaster'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'id'),
            value: VariableNode(name: NameNode(value: 'productMasterId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'sizes'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'colors'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'products'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'productId'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'priceAdditional'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'color'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'size'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: 'myAddresses'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'receiver'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'phone'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'zipCode'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'address'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'detailAddress'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'default'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
    ]),
  )
]);

class MyAddressesAndProductMasterQuery extends GraphQLQuery<
    MyAddressesAndProductMaster$Query, MyAddressesAndProductMasterArguments> {
  MyAddressesAndProductMasterQuery({required this.variables});

  @override
  final DocumentNode document = MY_ADDRESSES_AND_PRODUCT_MASTER_QUERY_DOCUMENT;

  @override
  final String operationName =
      MY_ADDRESSES_AND_PRODUCT_MASTER_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final MyAddressesAndProductMasterArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  MyAddressesAndProductMaster$Query parse(Map<String, dynamic> json) =>
      MyAddressesAndProductMaster$Query.fromJson(json);
}

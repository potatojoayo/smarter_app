import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getIcon(state) {
  switch (state) {
    case '묶음배송':
      return FontAwesomeIcons.solidCartFlatbedBoxes;
    case '시안요청':
      return FontAwesomeIcons.uniformMartialArts;
    case '시안완료':
      return FontAwesomeIcons.uniformMartialArts;
    case '배송중':
      return FontAwesomeIcons.solidTruckFast;
    case '간편주문완료':
      return FontAwesomeIcons.solidCartShoppingFast;
    case '간편주문 결제요청':
      return FontAwesomeIcons.solidWallet;
    case '결제완료':
      return FontAwesomeIcons.solidCreditCardFront;
    case '입금확인':
      return FontAwesomeIcons.solidMoneyCheckDollar;
    case '후작업중':
    case '전처리작업중':
      return FontAwesomeIcons.solidPaintRoller;
    case '출고준비':
      return FontAwesomeIcons.solidBoxesPacking;
    case '배송지연':
      return FontAwesomeIcons.solidAlarmExclamation;
    case '전처리작업완료':
    case '후작업완료':
    case '작업완료':
    case '배송완료':
      return FontAwesomeIcons.solidOctagonCheck;
    case '취소요청':
      return FontAwesomeIcons.ban;
    case '반품요청':
      return FontAwesomeIcons.arrowRotateLeft;
    case '교환요청':
      return FontAwesomeIcons.rightLeft;
    case '취소완료':
    case '주문취소':
    case '반품완료':
    case '교환완료':
    case '회원가입승인':
      return FontAwesomeIcons.solidOctagonCheck;
    case '반품반려':
    case '교환반려':
      return FontAwesomeIcons.solidCircleExclamation;
    case '무통장입금안내':
      return FontAwesomeIcons.solidEnvelopeOpenDollar;
    case '충전':
      return FontAwesomeIcons.solidCoins;
    case '주문확인':
    case '무통장입금':
      return FontAwesomeIcons.solidCommentDollar;
    case '외부작업':
      return FontAwesomeIcons.solidToolbox;
    case '체육관승급일 15일전 알림':
    case '학생승급일 15일전 알림':
    case '학생승급일 7일전 알림':
    case '체육관승급일 7일전 알림':
      return FontAwesomeIcons.solidAwardSimple;
    case '결석예정 알림':
      return FontAwesomeIcons.solidPersonCircleXmark;
    case '등원알림':
      return FontAwesomeIcons.solidPersonWalkingArrowRight;
    case '하원알림':
      return FontAwesomeIcons.solidPersonWalkingArrowLoopLeft;
    case '결석알림':
      return FontAwesomeIcons.solidPersonCircleXmark;
    case '알림장알림':
      return FontAwesomeIcons.solidFilePen;
    case '학원비 청구서 발급':
      return FontAwesomeIcons.solidFileInvoiceDollar;
    case '학원비 수금일 알림':
      return FontAwesomeIcons.solidMoneyBill1;
    default:
      return FontAwesomeIcons.circleInfo;
  }
}

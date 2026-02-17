import 'package:bridge/features/chat/domain/entities/chat_room.dart';
import 'package:bridge/features/transaction/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionStatusWidget extends ConsumerWidget {
  const TransactionStatusWidget({
    super.key,
    required this.roomId,
    required this.room,
  });

  final String roomId;
  final ChatRoom room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO 1: transactionStreamProvider를 watch하여 실시간 데이터를 가져오세요.
    // 데이터가 로딩 중이거나 에러가 났을 때의 처리도 필요합니다.
    // 데이터가 없으면(null) -> '거래 시작' 버튼 보여주기
    // 데이터가 있으면 -> '거래 상태' 및 '액션 버튼' 보여주기

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: const Text('Transaction Status Widget Skeleton'),
    );
  }

  // TODO 2: 거래 시작 버튼 UI 및 로직 구현
  // 상대방 ID를 찾아서 Transaction 객체를 생성하고 repository.upsert() 호출
  Widget _buildCreateTransactionButton(BuildContext context, WidgetRef ref, String myUserId) {
    return const SizedBox.shrink();
  }

  // TODO 3: 거래 상태별 UI (배경색, 텍스트, 버튼) 구현
  // Proposed(제안됨) -> 수락/취소 버튼
  // Accepted(수락됨) -> 진행 시작/취소 버튼
  // InProgress(진행중) -> 완료/취소 버튼
  // Completed(완료) -> 완료 텍스트
  Widget _buildTransactionStatus(BuildContext context, WidgetRef ref, Transaction tx, String myUserId) {
    return const SizedBox.shrink();
  }
}

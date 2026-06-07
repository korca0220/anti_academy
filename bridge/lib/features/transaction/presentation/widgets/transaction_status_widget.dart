import 'package:bridge/app/theme/app_colors.dart';
import 'package:bridge/features/chat/domain/entities/chat_room.dart';
import 'package:bridge/features/review/presentation/widgets/review_bottom_sheet.dart';
import 'package:bridge/features/transaction/domain/entities/transaction.dart';
import 'package:bridge/features/transaction/presentation/providers/transaction_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/theme/app_text_styles.dart';

class TransactionStatusWidget extends ConsumerWidget {
  const TransactionStatusWidget({
    super.key,
    required this.roomId,
    required this.room,
  });

  static const EdgeInsets marginPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  final String roomId;
  final ChatRoom room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionStream = ref.watch(transactionStreamProvider(roomId));

    return transactionStream.when(
        error: (error, stackTrace) => const Text('Error'),
        loading: SizedBox.shrink,
        data: (transaction) {
          if (transaction == null) {
            return _buildCreateTransactionButton(
                context, ref, room.participants.first.id);
          }

          return _buildTransactionStatus(
              context, ref, transaction, room.participants.first.id);
        });
  }

  Widget _buildCreateTransactionButton(
      BuildContext context, WidgetRef ref, String myUserId) {
    final providerId = room.participants
        .firstWhere((participant) => participant.id != myUserId)
        .id;

    return GestureDetector(
      onTap: () async {
        final newTransaction = Transaction(
          id: const Uuid().v4(),
          roomId: roomId,
          requesterId: myUserId,
          providerId: providerId,
          status: TransactionStatus.proposed,
          updatedBy: myUserId,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await ref.read(transactionRepositoryProvider).upsert(newTransaction);
      },
      child: Container(
        margin: marginPadding,
        padding: marginPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primary,
        ),
        child: Text(
          '이 이웃과 거래를 시작할까요?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionStatus(
      BuildContext context, WidgetRef ref, Transaction tx, String myUserId) {
    return Container(
        margin: marginPadding,
        padding: marginPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: switch (tx.status) {
            TransactionStatus.proposed => Colors.orange[100],
            TransactionStatus.accepted ||
            TransactionStatus.in_progress =>
              Colors.lightBlue,
            TransactionStatus.completed => Colors.grey[300],
            _ => Colors.white,
          },
        ),
        child: switch (tx.status) {
          TransactionStatus.proposed => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '거래 제안 중',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (tx.requesterId == myUserId) ...[
                  GestureDetector(
                    onTap: () async {
                      await ref
                          .read(transactionRepositoryProvider)
                          .updateStatus(
                            roomId: roomId,
                            status: TransactionStatus.canceled,
                            actorId: myUserId,
                          );
                    },
                    child: Container(
                      padding: marginPadding,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '취소',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
                if (tx.providerId == myUserId) ...[
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await ref
                              .read(transactionRepositoryProvider)
                              .updateStatus(
                                roomId: roomId,
                                status: TransactionStatus.accepted,
                                actorId: myUserId,
                              );
                        },
                        child: Container(
                          padding: marginPadding,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '수락',
                            style: AppTextStyles.labelLarge
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          await ref
                              .read(transactionRepositoryProvider)
                              .updateStatus(
                                roomId: roomId,
                                status: TransactionStatus.canceled,
                                actorId: myUserId,
                              );
                        },
                        child: Container(
                          padding: marginPadding,
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '거절',
                            style: AppTextStyles.labelLarge
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          TransactionStatus.accepted || TransactionStatus.in_progress => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '거래가 진행중입니다.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.surface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await ref
                            .read(transactionRepositoryProvider)
                            .updateStatus(
                              roomId: roomId,
                              status: TransactionStatus.completed,
                              actorId: myUserId,
                            );
                      },
                      child: Container(
                        padding: marginPadding,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '거래 완료',
                          style: AppTextStyles.labelLarge
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        await ref
                            .read(transactionRepositoryProvider)
                            .updateStatus(
                              roomId: roomId,
                              status: TransactionStatus.canceled,
                              actorId: myUserId,
                            );
                      },
                      child: Container(
                        padding: marginPadding,
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '취소',
                          style: AppTextStyles.labelLarge
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          TransactionStatus.completed => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '거래가 완료되었습니다.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final revieweeId = _resolveRevieweeId(tx, myUserId);
                    if (revieweeId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('리뷰 대상 사용자를 찾을 수 없습니다.')),
                      );
                      return;
                    }

                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: ReviewBottomSheet(
                          transactionId: tx.id,
                          roomId: roomId,
                          reviewerId: myUserId,
                          revieweeId: revieweeId,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: marginPadding,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '리뷰 남기기',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          TransactionStatus.canceled => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '거래가 취소되었습니다.',
                      style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await ref.read(transactionRepositoryProvider).updateStatus(
                          roomId: roomId,
                          status: TransactionStatus.proposed,
                          actorId: myUserId,
                        );
                  },
                  child: Container(
                    padding: marginPadding,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '다시 거래 제안하기',
                      style: AppTextStyles.labelLarge
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
        });
  }

  String? _resolveRevieweeId(Transaction tx, String myUserId) {
    if (tx.requesterId == myUserId) {
      return tx.providerId;
    }
    return tx.requesterId;
  }
}

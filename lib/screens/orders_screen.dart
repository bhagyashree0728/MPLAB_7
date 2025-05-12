import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/theme.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          title: const Text('My Orders'),
          backgroundColor: AppTheme.surfaceDark,
          foregroundColor: AppTheme.textPrimary,
          bottom: TabBar(
            labelColor: AppTheme.textPrimary,
            unselectedLabelColor: AppTheme.textSecondary,
            indicatorColor: AppTheme.goldenYellow,
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: Consumer<OrderService>(
          builder: (context, orderService, child) {
            if (orderService.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppTheme.goldenYellow),
              );
            }

            if (orderService.error != null) {
              return Center(
                child: Text(
                  orderService.error!,
                  style: TextStyle(color: AppTheme.error),
                ),
              );
            }

            return TabBarView(
              children: [
                _buildOrdersList(context, orderService.activeOrders),
                _buildOrdersList(context, orderService.pastOrders),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No orders found',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order #${order.id}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order.status),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order.status.toString().split('.').last,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Placed on ${_formatDate(order.date)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...order.items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item.quantity}x ${item.foodItem.name}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            '\$${(item.foodItem.price * item.quantity).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    )),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${order.totalAmount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.goldenYellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (order.status == OrderStatus.preparing || order.status == OrderStatus.ready)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.lightBlue,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Track Order',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTrackingSteps(order.status),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrackingSteps(OrderStatus status) {
    final steps = [
      {'icon': Icons.shopping_cart, 'label': 'Order Placed', 'isCompleted': true},
      {'icon': Icons.restaurant, 'label': 'Preparing', 'isCompleted': status != OrderStatus.pending},
      {'icon': Icons.delivery_dining, 'label': 'On the way', 'isCompleted': status == OrderStatus.ready},
      {'icon': Icons.home, 'label': 'Delivered', 'isCompleted': status == OrderStatus.delivered},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: steps.map((step) {
        final isCompleted = step['isCompleted'] as bool;
        return Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted ? AppTheme.goldenYellow : AppTheme.textSecondary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                step['icon'] as IconData,
                color: AppTheme.darkPurple,
                size: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              step['label'] as String,
              style: TextStyle(
                color: isCompleted ? AppTheme.textPrimary : AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return AppTheme.lightBlue;
      case OrderStatus.confirmed:
      case OrderStatus.preparing:
        return AppTheme.goldenYellow;
      case OrderStatus.ready:
        return AppTheme.goldenYellow;
      case OrderStatus.delivered:
        return AppTheme.success;
      case OrderStatus.cancelled:
        return AppTheme.error;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
} 
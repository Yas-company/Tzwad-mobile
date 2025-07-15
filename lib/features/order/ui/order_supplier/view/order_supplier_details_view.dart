import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';

class OrderSupplierDetailsView extends StatelessWidget {
  const OrderSupplierDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'اسواق بن داوود', 'quantity': 2, 'price': 102.5, 'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'},
      {'title': 'اسواق بن داوود', 'quantity': 1, 'price': 85.0, 'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'},
      {'title': 'اسواق بن داوود', 'quantity': 6, 'price': 119.9, 'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'},
      {'title': 'اسواق بن داوود', 'quantity': 2, 'price': 102.5, 'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'},
      {'title': 'اسواق بن داوود', 'quantity': 1, 'price': 32.7, 'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'},
      {'title': 'اسواق بن داوود', 'quantity': 2, 'price': 420.6, 'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب',), centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 16),
            _buildUserInfo(),
            const SizedBox(height: 16),
            _buildAddressSection(),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              'تفاصيل الطلب',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...items.map((item) => _buildOrderItem(item)),
            const Divider(),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'السعر النهائي  464.55 ر.س',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(flex:2,child: AppButtonWidget(label:'تم تسليم الطلب', onPressed:() {

            },)),
            const SizedBox(width: 12),
            Expanded(
              child: AppButtonWidget(label:'المساعدة', onPressed:() {
              
              },backgroundColor:Colors.white,textColor:ColorManager.colorPrimary,
              borderColor:ColorManager.colorPrimary,),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('5 أغسطس 2025'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text('جاهزة للشحن', style: TextStyle(color: Colors.teal)),
        )
      ],
    );
  }

  Widget _buildUserInfo() {
    return const Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('محمد عبدالرحمن', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('منتج 13 | #1029181', style: TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'العنوان',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text(
          'الرياض - حي العزيزية - شارع الملك عبدالعزيز، متفرع من شارع الملك فهد، فيلا 2172 - الدور 3',
          textDirection: TextDirection.rtl,
        ),
        TextButton(
          onPressed: () {},
          child: const Text('الخريطة', style: TextStyle(color: Colors.teal)),
        )
      ],
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.network(
            item['image'],
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text('${item['quantity']} x ${item['title']}'),
          ),
          Text('${item['price']} ر.س'),
        ],
      ),
    );
  }
}

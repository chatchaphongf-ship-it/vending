import 'package:flutter/material.dart';

void main() {
  runApp(const BakeryApp());
}

class BakeryApp extends StatelessWidget {
  const BakeryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakery Vending Machine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9E7777),
          primary: const Color(0xFF9E7777),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8EA),
        useMaterial3: true,
      ),
      home: const BakeryVendingMachine(),
    );
  }
}

class BakeryVendingMachine extends StatefulWidget {
  const BakeryVendingMachine({super.key});

  @override
  State<BakeryVendingMachine> createState() => _BakeryVendingMachineState();
}

class _BakeryVendingMachineState extends State<BakeryVendingMachine>
    with SingleTickerProviderStateMixin {
  String selectedCategory = 'ทั้งหมด';
  String paymentMethod = 'cash'; // 'cash' หรือ 'qr'

  late AnimationController _dropController;
  late Animation<Offset> _dropAnimation;

  final List<String> categories = [
    'ทั้งหมด',
    'ขนมปัง & เพสตรี',
    'เค้ก & ของหวาน',
    'เครื่องดื่ม',
  ];

  final List<Map<String, dynamic>> items = [
    {
      'name': '🍞 ขนมปังเนยสด',
      'price': 45,
      'stock': 10,
      'category': 'ขนมปัง & เพสตรี',
      'image': 'assets/images/1.png',
      'storage': 'เก็บในอุณหภูมิห้องได้ 3 วัน หรือตู้เย็นช่องธรรมดา 7 วัน',
    },
    {
      'name': '🥐 ครัวซองต์เนยสด',
      'price': 65,
      'stock': 10,
      'category': 'ขนมปัง & เพสตรี',
      'image': 'assets/images/2.png',
      'storage': 'เก็บในอุณหภูมิห้องได้ 2 วัน ก่อนทานแนะนำอบซ้ำที่ 170°C 2 นาที',
    },
    {
      'name': '🥯 เบเกิลโฮลวีต',
      'price': 55,
      'stock': 10,
      'category': 'ขนมปัง & เพสตรี',
      'image': 'assets/images/3.jpg',
      'storage': 'เก็บในอุณหภูมิห้องได้ 3 วัน หากแช่ช่องฟรีซเก็บได้นาน 1 เดือน',
    },
    {
      'name': '🥖 ขนมปังกระเทียม',
      'price': 49,
      'stock': 10,
      'category': 'ขนมปัง & เพสตรี',
      'image': 'assets/images/4.jpg',
      'storage': 'เก็บในอุณหภูมิห้องได้ 2 วัน ควรอุ่นก่อนรับประทาน',
    },
    {
      'name': '🧁 ชูครีมซอฟต์ไส้ครีม',
      'price': 39,
      'stock': 10,
      'category': 'เค้ก & ของหวาน',
      'image': 'assets/images/5.jpg',
      'storage': 'ควรเก็บในตู้เย็นตลอดเวลา (2-5°C) รับประทานภายใน 2 วัน',
    },
    {
      'name': '🍰 เค้กช็อกโกแลตหน้านิ่ม',
      'price': 95,
      'stock': 10,
      'category': 'เค้ก & ของหวาน',
      'image': 'assets/images/6.jpg',
      'storage': 'แช่เย็นตลอดเวลา เก็บได้นาน 3-5 วัน',
    },
    {
      'name': '🫐 ชีสเค้กบลูเบอร์รี',
      'price': 110,
      'stock': 10,
      'category': 'เค้ก & ของหวาน',
      'image': 'assets/images/7.jpg',
      'storage': 'แช่เย็นตลอดเวลา เก็บได้นาน 5 วัน',
    },
    {
      'name': '🍊 เค้กส้ม',
      'price': 85,
      'stock': 10,
      'category': 'เค้ก & ของหวาน',
      'image': 'assets/images/8.jpg',
      'storage': 'แช่เย็นตลอดเวลา เก็บได้นาน 4 วัน',
    },
    {
      'name': '☕ ทิรามิสุ',
      'price': 105,
      'stock': 10,
      'category': 'เค้ก & ของหวาน',
      'image': 'assets/images/9.jpg',
      'storage': 'แช่เย็นตลอดเวลา ควรรับประทานภายใน 2 วัน',
    },
    {
      'name': '🧁 คัพเค้กวานิลลา',
      'price': 55,
      'stock': 10,
      'category': 'เค้ก & ของหวาน',
      'image': 'assets/images/10.jpg',
      'storage': 'เก็บในอุณหภูมิห้องได้ 2 วัน หรือแช่เย็น 5 วัน',
    },
    {
      'name': '🍪 คุกกี้ช็อกชิป',
      'price': 35,
      'stock': 10,
      'category': 'ขนมปัง & เพสตรี',
      'image': 'assets/images/11.jpg',
      'storage': 'เก็บในภาชนะปิดสนิทได้นาน 14 วัน',
    },
    {
      'name': '🍫 บราวนี่อัลมอนด์',
      'price': 55,
      'stock': 10,
      'category': 'เค้ก & ของหวาน',
      'image': 'assets/images/12.jpg',
      'storage': 'เก็บอุณหภูมิห้องได้ 5 วัน หรือแช่เย็นได้ 14 วัน',
    },
    {
      'name': '🍥 มาการอง',
      'price': 45,
      'stock': 10,
      'category': 'เค้ก & ของหวาน',
      'image': 'assets/images/13.jpg',
      'storage': 'แช่เย็นตลอดเวลา เก็บได้นาน 7 วัน',
    },
    {
      'name': '🥧 พายสับปะรด',
      'price': 39,
      'stock': 10,
      'category': 'ขนมปัง & เพสตรี',
      'image': 'assets/images/14.jpg',
      'storage': 'เก็บอุณหภูมิห้องได้ 7 วัน',
    },
    {
      'name': '🍩 โดนัทน้ำตาลเคลือบ',
      'price': 45,
      'stock': 10,
      'category': 'ขนมปัง & เพสตรี',
      'image': 'assets/images/15.jpg',
      'storage': 'ควรรับประทานสดใหม่วันต่อวัน',
    },
    {
      'name': '☕ อเมริกาโน',
      'price': 55,
      'stock': 10,
      'category': 'เครื่องดื่ม',
      'image': 'assets/images/16.jpg',
      'storage': 'ควรรับประทานทันที หรือแช่เย็นไว้ไม่เกิน 24 ชั่วโมง',
    },
    {
      'name': '🥛 ลาเต้',
      'price': 65,
      'stock': 10,
      'category': 'เครื่องดื่ม',
      'image': 'assets/images/17.jpg',
      'storage': 'ควรรับประทานทันที หรือแช่เย็นไว้ไม่เกิน 24 ชั่วโมง',
    },
    {
      'name': '🧋 ชาไทยเย็น',
      'price': 55,
      'stock': 10,
      'category': 'เครื่องดื่ม',
      'image': 'assets/images/18.jpg',
      'storage': 'ควรรับประทานทันที หรือแช่เย็นไว้ไม่เกิน 24 ชั่วโมง',
    },
    {
      'name': '🥤 โกโก้เย็น',
      'price': 65,
      'stock': 10,
      'category': 'เครื่องดื่ม',
      'image': 'assets/images/19.jpg',
      'storage': 'ควรรับประทานทันที หรือแช่เย็นไว้ไม่เกิน 24 ชั่วโมง',
    },
  ];

  final Map<String, int> cart = {};
  int insertedMoney = 0;

  @override
  void initState() {
    super.initState();
    // สร้าง Animation Controller สำหรับการตกของสินค้า
    _dropController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // ใช้ Curves.bounceOut เพื่อเพิ่มฟีลลิ่งสินค้าตกกระทบถาดแล้วเด้งเบาๆ
    _dropAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0.3),
    ).animate(CurvedAnimation(
      parent: _dropController,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    _dropController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == 'ทั้งหมด') {
      return items;
    }
    return items.where((item) => item['category'] == selectedCategory).toList();
  }

  int get totalPrice {
    int total = 0;
    cart.forEach((itemName, qty) {
      final item = items.firstWhere((element) => element['name'] == itemName);
      total += (item['price'] as int) * qty;
    });
    return total;
  }

  void addToCart(String itemName) {
    final item = items.firstWhere((element) => element['name'] == itemName);
    final currentInCart = cart[itemName] ?? 0;

    if (currentInCart + 1 > item['stock']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('สินค้า "${item['name']}" หมดแล้ว!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      cart[itemName] = currentInCart + 1;
    });
  }

  void showStorageInfo(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('💡 การเก็บรักษา: ${item['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('หมวดหมู่: ${item['category']}'),
            const SizedBox(height: 8),
            Text(item['storage'] ?? 'ไม่มีข้อมูลการเก็บรักษา'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('เข้าใจแล้ว'),
          ),
        ],
      ),
    );
  }

  void insertMoney(int amount) {
    setState(() {
      insertedMoney += amount;
    });
  }

  void clearCart() {
    setState(() {
      cart.clear();
    });
  }

  void refundMoney() {
    if (insertedMoney > 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('🔄 คืนเงิน'),
          content: Text('ระบบทำการคืนเงิน $insertedMoney บาท เรียบร้อยแล้ว'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
      setState(() {
        insertedMoney = 0;
      });
    }
  }

  void processPayment() {
    if (totalPrice == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณาเลือกสินค้าอย่างน้อย 1 ชิ้น')),
      );
      return;
    }

    if (paymentMethod == 'cash') {
      if (insertedMoney < totalPrice) {
        final needed = totalPrice - insertedMoney;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เงินไม่พอ! ขาดอีก $needed บาท'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
      _startDropAnimationAndComplete(insertedMoney - totalPrice);
    } else {
      _showQRPaymentDialog();
    }
  }

  void _showQRPaymentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('📱 สแกน QR Code ชำระเงิน', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ยอดชำระทั้งสิ้น: $totalPrice บาท',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: const Column(
                children: [
                  Icon(Icons.qr_code_2, size: 180, color: Colors.black87),
                  SizedBox(height: 4),
                  Text('PromptPay / พร้อมเพย์', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text('กรุณาสแกนเพื่อชำระเงินผ่าน Mobile Banking', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              _startDropAnimationAndComplete(0);
            },
            child: const Text('จำลองชำระเงินสำเร็จ'),
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันแสดงอนิเมชั่นของตก แล้วจึงโชว์หน้าต่างสรุปบิล
  Future<void> _startDropAnimationAndComplete(int change) async {
    // ดึงรูปภาพสินค้าแรกในตะกร้ามาทำอนิเมชั่น
    final firstItemName = cart.keys.first;
    final itemData = items.firstWhere((it) => it['name'] == firstItemName);

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          // พื้นหลังสีดำจางๆ
          Container(color: Colors.black38),
          SlideTransition(
            position: _dropAnimation,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5AB),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black45, blurRadius: 10, spreadRadius: 2)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '🎁 สินค้ากำลังหล่นลงถาด...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        itemData['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) =>
                            const Icon(Icons.fastfood, size: 60, color: Colors.orange),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // แสดง Overlay บนหน้าจอ
    Overlay.of(context).insert(overlayEntry);

    // เริ่มเล่นอนิเมชั่น
    _dropController.reset();
    await _dropController.forward();
    await Future.delayed(const Duration(milliseconds: 400)); // หน่วงเวลาให้ผู้ใช้เห็นแป๊บนึง

    // ปิด Overlay
    overlayEntry.remove();

    // ทำการตัดสต็อกและเปิด Dialog สรุปรายการ
    _completeOrder(change);
  }

  void _completeOrder(int change) {
    final finalCartList = Map<String, int>.from(cart);
    final finalPrice = totalPrice;

    setState(() {
      cart.forEach((itemName, qty) {
        final item = items.firstWhere((element) => element['name'] == itemName);
        item['stock'] -= qty;
      });
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🛒 ทำรายการสำเร็จ!'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('รายการสินค้าที่ได้รับ:'),
              const SizedBox(height: 8),
              ...finalCartList.entries.map((e) => Text('- ${e.key} x ${e.value}')),
              const Divider(height: 20),
              Text('ราคารวม: $finalPrice บาท'),
              Text('ช่องทางชำระเงิน: ${paymentMethod == 'cash' ? 'เงินสด' : 'PromptPay QR'}'),
              if (paymentMethod == 'cash') Text('เงินที่จ่าย: $insertedMoney บาท'),
              Text(
                'เงินทอน: $change บาท',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                cart.clear();
                insertedMoney = 0;
              });
            },
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🥖 Bakery Vending Machine 🥐'),
        centerTitle: true,
        backgroundColor: const Color(0xFF9E7777),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 700;
                return isWideScreen ? _buildWideLayout() : _buildMobileLayout();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(cat),
              selectedColor: const Color(0xFF9E7777),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (selected) {
                setState(() {
                  selectedCategory = cat;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildProductGrid(crossAxisCount: 3)),
        Expanded(flex: 2, child: SingleChildScrollView(child: _buildCartAndPaymentSection())),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 480, child: _buildProductGrid(crossAxisCount: 2)),
          _buildCartAndPaymentSection(),
        ],
      ),
    );
  }

  Widget _buildProductGrid({required int crossAxisCount}) {
    final currentItems = filteredItems;
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: currentItems.length,
      itemBuilder: (context, index) {
        final item = currentItems[index];
        return Card(
          color: const Color(0xFFF3E5AB),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            item['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.fastfood, size: 40, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white70,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.info_outline, size: 18, color: Colors.brown),
                            onPressed: () => showStorageInfo(item),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['name'],
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('${item['price']} บาท', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                Text(
                  'คงเหลือ: ${item['stock']}',
                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6E85B7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                    ),
                    onPressed: () => addToCart(item['name']),
                    child: const Text('ใส่ตะกร้า', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCartAndPaymentSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '🛒 ตะกร้าสินค้า',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (cart.isEmpty)
                    const Text('ยังไม่มีสินค้าในตะกร้า', style: TextStyle(color: Colors.grey))
                  else
                    ...cart.entries.map((e) {
                      final item = items.firstWhere((it) => it['name'] == e.key);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text('${e.key} x ${e.value} = ${item['price'] * e.value} บาท'),
                      );
                    }),
                  const Divider(),
                  Text(
                    'ราคารวม: $totalPrice บาท',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                  TextButton(
                    onPressed: clearCart,
                    child: const Text('ล้างตะกร้า', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('💳 เลือกวิธีชำระเงิน', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('เงินสด', style: TextStyle(fontSize: 13)),
                          value: 'cash',
                          // ignore: deprecated_member_use
                          groupValue: paymentMethod,
                          // ignore: deprecated_member_use
                          onChanged: (val) => setState(() => paymentMethod = val!),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('QR Code', style: TextStyle(fontSize: 13)),
                          value: 'qr',
                          // ignore: deprecated_member_use
                          groupValue: paymentMethod,
                          // ignore: deprecated_member_use
                          onChanged: (val) => setState(() => paymentMethod = val!),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  if (paymentMethod == 'cash') ...[
                    Text(
                      '💰 เงินที่ใส่เข้ามา: $insertedMoney บาท',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [20, 50, 100, 500, 1000].map((amount) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC4D7B1)),
                          onPressed: () => insertMoney(amount),
                          child: Text('+$amount฿'),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 6),
                    OutlinedButton(
                      onPressed: refundMoney,
                      child: const Text('ยกเลิกและคืนเงิน'),
                    ),
                  ] else ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('📱 สแกน QR Code เพื่อชำระเงินผ่าน Mobile Banking', textAlign: TextAlign.center),
                    ),
                  ],
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: processPayment,
                    child: Text(
                      paymentMethod == 'cash' ? 'ชำระเงิน / รับสินค้า' : 'สร้าง QR Code ชำระเงิน',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
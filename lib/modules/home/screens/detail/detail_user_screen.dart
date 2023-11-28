import 'package:flutter/material.dart';
import '../../screens/detail/detail_user_arguments.dart';
import '../../widgets/detail_banner_widget.dart';

class DetailUserScreen extends StatefulWidget {
  final DetailUserArguments args;

  const DetailUserScreen(this.args, {super.key});

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade800,
        elevation: 0,
        title: const Text(
          'Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DetailBannerWidget(
              widget.args.userName, widget.args.email, widget.args.avatarUrl),
          SizedBox(
            height: 50,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Post',
                ),
                Tab(
                  text: 'Tagged',
                ),
              ],
              labelColor: Colors.indigo,
            ),
          ),
          SizedBox(
            height: 100,
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(
                  child: Text('Post Feed'),
                ),
                Center(
                  child: Text('Tagged Feed'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

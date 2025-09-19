/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:civic_connect/chat_popup.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _selectedIndex = 3; // Community tab selected

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else if (index == 1) {
      Navigator.pushNamed(context, '/my-reports');
    } else if (index == 4) {
      Navigator.pushNamed(context, '/member');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showChatPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ChatPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'CC',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 26),
            onPressed: () => Navigator.pushNamed(context, '/issue-form'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCityImpactCard(),
              const SizedBox(height: 24),
              _buildTrendingIssues(),
              const SizedBox(height: 24),
              _buildRecentActivity(),
              const SizedBox(height: 24),
              _buildPopularCategories(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/issue-form'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'City Impact Today',
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending Issues',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildTrendingCard(
          title: 'Road Issues',
          subtitle: '15 reports in last 2 hours',
          icon: Icons.remove_road,
          color: const Color(0xFFFF6B6B),
          status: 'HOT',
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Streetlights',
          subtitle: '8 reports today',
          icon: Icons.lightbulb_outline,
          color: const Color(0xFFFFB347),
          status: 'WARM',
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Parks & Recreation',
          subtitle: '3 reports today',
          icon: Icons.park,
          color: const Color(0xFF4ECDC4),
          status: 'COOL',
        ),
      ],
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Refresh',
                style: GoogleFonts.poppins(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        _buildActivityItem(
          icon: Icons.lightbulb_outline,
          iconColor: Colors.orange,
          iconBg: Colors.orange.shade100,
          title: 'New streetlight issue reported',
          subtitle: 'Oak Avenue • 12 minutes ago',
          actionWidget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Text(
              'Support',
              style: GoogleFonts.poppins(
                color: Colors.blue.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildActivityItem(
          icon: Icons.build,
          iconColor: Colors.orange,
          iconBg: Colors.yellow.shade100,
          title: 'City crew working on Main St repairs',
          subtitle: 'Main Street • 1 hour ago',
          actionWidget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.yellow.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'In Progress',
              style: GoogleFonts.poppins(
                color: Colors.orange.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget actionWidget,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        actionWidget,
      ],
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Categories',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildCategoryCard(
                title: 'Roads',
                subtitle: '23 active',
                icon: Icons.map,
                color: Colors.green.shade100,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildCategoryCard(
                title: 'Utilities',
                subtitle: '12 active',
                icon: Icons.flash_on,
                color: Colors.yellow.shade100,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.black54),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.list_alt, 'My Reports', 1),
          const SizedBox(width: 48),
          _buildNavItem(Icons.people, 'Community', 3),
          _buildNavItem(Icons.person, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.blue.shade700 : Colors.grey),
      onPressed: () => _onItemTapped(index),
    );
  }
}*/
// Replace your existing community.dart with this version
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:civic_connect/chat_popup.dart';
import 'models/post.dart'; // Import the Post model
import 'widgets/feed_post.dart'; // Import the FeedPost widget

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  int _selectedIndex = 3; // Community tab selected
  late TabController _tabController;
  List<Post> _feedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSamplePosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else if (index == 1) {
      Navigator.pushNamed(context, '/my-reports');
    } else if (index == 4) {
      Navigator.pushNamed(context, '/member');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _loadSamplePosts() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _feedPosts = [
          Post(
            id: '1',
            userId: 'user1',
            username: 'CitizenReporter',
            imageUrl: 'https://picsum.photos/400/300?random=1',
            caption: 'Pothole on Main Street causing traffic issues. This needs immediate attention! #RoadSafety #CivicDuty',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 24,
            comments: 8,
            isLiked: false,
            location: 'Main Street, Downtown',
            issueType: 'Road Issue',
          ),
          Post(
            id: '2',
            userId: 'user2',
            username: 'LocalHero',
            imageUrl: 'https://picsum.photos/400/300?random=2',
            caption: 'Street light has been out for 3 days. Making it unsafe for pedestrians at night.',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            likes: 31,
            comments: 12,
            isLiked: true,
            location: 'Oak Avenue',
            issueType: 'Streetlight',
          ),
          Post(
            id: '3',
            userId: 'user3',
            username: 'CommunityWatch',
            imageUrl: 'https://picsum.photos/400/300?random=3',
            caption: 'Park cleanup was successful! Thanks to everyone who participated. Our community is stronger together!',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            likes: 156,
            comments: 23,
            isLiked: false,
            location: 'Central Park',
            issueType: 'Community Event',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _feedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = _feedPosts[postIndex];
        _feedPosts[postIndex] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    // For now, just show a simple dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Comments for ${post.username}\'s post'),
        content: const Text('Comments feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'CC',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.black, size: 24),
            onPressed: () => Navigator.pushNamed(context, '/issue-form'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 24),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildTrendingTab(),
          _buildStatsTab(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/issue-form'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildFeedTab() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _isLoading = true;
        });
        _loadSamplePosts();
      },
      child: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          final post = _feedPosts[index];
          return FeedPostWidget(
            post: post,
            onLikePressed: _toggleLike,
            onCommentPressed: _showComments,
          );
        },
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrendingIssues(),
          const SizedBox(height: 24),
          _buildPopularCategories(),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCityImpactCard(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  // Keep your existing methods for trending issues, stats, etc.
  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending Issues',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildTrendingCard(
          title: 'Road Issues',
          subtitle: '15 reports in last 2 hours',
          icon: Icons.remove_road,
          color: const Color(0xFFFF6B6B),
          status: 'HOT',
        ),
        const SizedBox(height: 12),
        _buildTrendingCard(
          title: 'Streetlights',
          subtitle: '8 reports today',
          icon: Icons.lightbulb_outline,
          color: const Color(0xFFFFB347),
          status: 'WARM',
        ),
      ],
    );
  }

  Widget _buildTrendingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'City Impact Today',
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                _loadSamplePosts();
              },
              child: Text(
                'Refresh',
                style: GoogleFonts.poppins(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Widget actionWidget,
  }) {
    return Row(
      children: [
      Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: iconBg,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: 20),
    ),
    const Size*/
// lib/community.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/post.dart'; // Import the Post model
import 'widgets/feed_post.dart'; // Import the FeedPost widget

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Default to Community tab (index 2)
  late TabController _tabController;
  List<Post> _feedPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSamplePosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    if (index == 1) Navigator.pushReplacementNamed(context, '/my-reports');
    // Index 2 is the current page, so do nothing
    // if (index == 3) Navigator.pushReplacementNamed(context, '/profile');
  }

  void _loadSamplePosts() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _feedPosts = [
          Post(
            id: '1',
            userId: 'user1',
            username: 'CitizenReporter',
            imageUrl: 'https://images.unsplash.com/photo-1519994999292-5e6f2f5ea25f?q=80&w=2074&auto=format&fit=crop',
            caption: 'Pothole on Main Street causing traffic issues. This needs immediate attention! #RoadSafety #CivicDuty',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            likes: 24,
            comments: 8,
            isLiked: false,
            location: 'Main Street, Downtown',
            issueType: 'Road Issue',
          ),
          Post(
            id: '2',
            userId: 'user2',
            username: 'LocalHero',
            imageUrl: 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?q=80&w=2070&auto=format&fit=crop',
            caption: 'Street light has been out for 3 days. Making it unsafe for pedestrians at night.',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            likes: 31,
            comments: 12,
            isLiked: true,
            location: 'Oak Avenue',
            issueType: 'Streetlight',
          ),
          Post(
            id: '3',
            userId: 'user3',
            username: 'CommunityWatch',
            imageUrl: 'https://images.unsplash.com/photo-1620155232732-676b5b4a4a5c?q=80&w=2070&auto=format&fit=crop',
            caption: 'Park cleanup was successful! Thanks to everyone who participated. Our community is stronger together!',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            likes: 156,
            comments: 23,
            isLiked: false,
            location: 'Central Park',
            issueType: 'Community Event',
          ),
        ];
        _isLoading = false;
      });
    });
  }

  void _toggleLike(String postId) {
    setState(() {
      final postIndex = _feedPosts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final post = _feedPosts[postIndex];
        _feedPosts[postIndex] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Comments for ${post.username}\'s post'),
        content: const Text('Comments feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Trending'),
            Tab(text: 'Stats'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildTrendingTab(),
          _buildStatsTab(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/report-issue'),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildFeedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoading = true);
        // In a real app, you would fetch new data from your backend here
        _loadSamplePosts();
      },
      child: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          final post = _feedPosts[index];
          return FeedPostWidget(
            post: post,
            onLikePressed: _toggleLike,
            onCommentPressed: _showComments,
          );
        },
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTrendingIssues(),
          const SizedBox(height: 24),
          _buildPopularCategories(), // This method is now defined below
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCityImpactCard(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.list_alt, 'My Reports', 1),
          const SizedBox(width: 48), // The space for the FAB
          _buildNavItem(Icons.people, 'Community', 2),
          _buildNavItem(Icons.person, 'Profile', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.blue.shade700 : Colors.grey),
      onPressed: () => _onItemTapped(index),
      tooltip: label,
    );
  }

  Widget _buildTrendingIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending Issues', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTrendingCard(title: 'Road Issues', subtitle: '15 reports in last 2 hours', icon: Icons.remove_road, color: Colors.red.shade400, status: 'HOT'),
        const SizedBox(height: 12),
        _buildTrendingCard(title: 'Streetlights', subtitle: '8 reports today', icon: Icons.lightbulb_outline, color: Colors.orange.shade400, status: 'WARM'),
      ],
    );
  }

  Widget _buildTrendingCard({ required String title, required String subtitle, required IconData icon, required Color color, required String status }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Text(status, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Popular Categories", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Add category widgets here
        const Text("Category widgets coming soon!")
      ],
    );
  }

  Widget _buildCityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('City Impact Today', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactStat('47', 'New Reports', Colors.black),
              _buildImpactStat('23', 'Resolved', Colors.green),
              _buildImpactStat('1,247', 'Active Citizens', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String count, String label, Color color) {
    return Column(
      children: [
        Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _loadSamplePosts();
              },
              child: Text('Refresh', style: GoogleFonts.poppins(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
          icon: Icons.check_circle,
          iconColor: Colors.green,
          iconBg: Colors.green.shade100,
          title: 'Citizen #247 reported pothole resolved',
          subtitle: 'Downtown • 5 minutes ago',
          actionWidget: const Icon(Icons.favorite_border, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildActivityItem({ required IconData icon, required Color iconColor, required Color iconBg, required String title, required String subtitle, required Widget actionWidget, }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
              ],
            )
        ),
        actionWidget,
      ],
    );
  }
}
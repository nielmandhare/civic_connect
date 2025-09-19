/*
// Create this file: lib/widgets/feed_post.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../models/post.dart';
import '../../services/bannerbear_service.dart';

class FeedPostWidget extends StatelessWidget {
  final Post post;
  final Function(String) onLikePressed;
  final Function(Post) onCommentPressed;

  const FeedPostWidget({
    Key? key,
    required this.post,
    required this.onLikePressed,
    required this.onCommentPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildImage(),
          _buildActions(context),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.shade200,
            child: Text(
              post.username[0].toUpperCase(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.username,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (post.location != null)
                  Text(
                    post.location!,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          if (post.issueType != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getIssueTypeColor(post.issueType!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                post.issueType!,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey[200],
      child: Image.network(
        post.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.grey,
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onLikePressed(post.id),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                post.isLiked ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(post.isLiked),
                color: post.isLiked ? Colors.red : Colors.grey[700],
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => onCommentPressed(post),
            child: Icon(
              Icons.chat_bubble_outline,
              color: Colors.grey[700],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => _sharePost(context),
            child: Icon(
              Icons.share,
              color: Colors.grey[700],
              size: 24,
            ),
          ),
          const Spacer(),
          Text(
            timeago.format(post.timestamp),
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.likes > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '${post.likes} ${post.likes == 1 ? 'like' : 'likes'}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${post.username} ',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: post.caption,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (post.comments > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () => onCommentPressed(post),
                child: Text(
                  'View all ${post.comments} comments',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getIssueTypeColor(String issueType) {
    switch (issueType.toLowerCase()) {
      case 'road issue':
        return Colors.red.shade400;
      case 'streetlight':
        return Colors.orange.shade400;
      case 'community event':
        return Colors.green.shade400;
      default:
        return Colors.blue.shade400;
    }
  }

  void _sharePost(BuildContext context) async {
    try {
      // Show loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Creating shareable image...')),
      );

      // Try to create image with BannerBear
      final shareableImageUrl = await BannerBearService.createShareableImage(
        imageUrl: post.imageUrl,
        caption: post.caption,
        username: post.username,
        location: post.location,
      );

      if (shareableImageUrl != null) {
        // Share the generated image
        await Share.share(
          'Check out this community report: $shareableImageUrl\n\n${post.caption}\n\nReported via CivicConnect',
          subject: 'Community Report - ${post.issueType ?? 'Issue'}',
        );
      } else {
        // Fallback to text sharing
        await Share.share(
          '${post.caption}\n\nLocation: ${post.location ?? 'Not specified'}\nReported by: @${post.username}\n\nShared via CivicConnect',
          subject: 'Community Report - ${post.issueType ?? 'Issue'}',
        );
      }
    } catch (e) {
      print('Share error: $e');
      // Simple text share as fallback
      await Share.share(
        '${post.caption}\n\nShared via CivicConnect',
        subject: 'Community Report',
      );
    }
  }
}*/
// lib/widgets/feed_post.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/post.dart';
import '../services/bannerbear_service.dart'; // For sharing functionality

class FeedPostWidget extends StatelessWidget {
  final Post post;
  final Function(String) onLikePressed;
  final Function(Post) onCommentPressed;

  const FeedPostWidget({
    Key? key,
    required this.post,
    required this.onLikePressed,
    required this.onCommentPressed,
  }) : super(key: key);

  Future<void> _sharePost(BuildContext context) async {
    // Show a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Call the Bannerbear service and PASS THE IMAGE URL
    final shareableImageUrl = await BannerBearService.createShareableImage(post.imageUrl);

    // Pop the dialog after the API call is complete
    if (context.mounted) {
      Navigator.pop(context);
    }

    if (shareableImageUrl != null) {
      // Show the generated image
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Share this Post!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(shareableImageUrl),
                const SizedBox(height: 8),
                const Text('A new shareable image was generated for this post.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    } else {
      // Show an error message if it fails
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not create shareable image.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${post.userId}'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        // FIX: Added the null-coalescing operator '??' to provide a default value.
                        post.location ?? 'No location provided',
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Post Image
          Image.network(
            post.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        post.isLiked ? Icons.favorite : Icons.favorite_border,
                        color: post.isLiked ? Colors.red : Colors.black,
                        size: 26,
                      ),
                      onPressed: () => onLikePressed(post.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.mode_comment_outlined, size: 26),
                      onPressed: () => onCommentPressed(post),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send_outlined, size: 26),
                      onPressed: () => _sharePost(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Likes and Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${post.likes} likes',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: '${post.username} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: post.caption),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'View all ${post.comments} comments',
                  style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
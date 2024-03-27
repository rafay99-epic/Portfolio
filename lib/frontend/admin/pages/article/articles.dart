// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/backend/article_functionality/article_functionality.dart';
import 'package:rafay_portfolio/backend/model/BlogModel.dart';
import 'package:rafay_portfolio/frontend/admin/pages/article/article_add.dart';
import 'package:rafay_portfolio/frontend/admin/pages/article/article_update.dart';
import 'package:rafay_portfolio/constants/widgets/admin_drawer.dart';
import 'package:rafay_portfolio/constants/widgets/textstyle.dart';

class BlogPostAdmin extends StatefulWidget {
  const BlogPostAdmin({Key? key}) : super(key: key);

  @override
  State<BlogPostAdmin> createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPostAdmin> {
  // ----------------------
  // Variable Controllers
  // ----------------------
  final ArticleFunctionality articleFunctionality = ArticleFunctionality();
  bool isSearchBarVisible = false;

  // ----------------------
  // Main Widget
  // ----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ----------------------
      // App Bar
      // ----------------------
      appBar: _buildAppBar(context),
      // ----------------------
      // Drawer Menu
      // ----------------------
      drawer: const MyDrawerAdmin(),
      backgroundColor: Theme.of(context).colorScheme.background,
      // ----------------------
      // Floating Button
      // ----------------------
      floatingActionButton: _buildFloatingActionButton(context),
      // ----------------------
      // Main Body
      // ----------------------
      body: _buildBody(context),
    );
  }

  // ----------------------
  // App Bar Widget
  // ----------------------
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Text('Blog Posts'),
          const Spacer(),
          // ----------------------
          // Add Blog Button
          // ----------------------
          _buildElvatedButtonArticleAdd(context),
          // ----------------------
          // Search Bar Widget
          // ----------------------
          _buildSearchBar(context),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearchBarVisible = !isSearchBarVisible;
              });
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  // ----------------------
  // Add Article Button
  // ----------------------
  Widget _buildElvatedButtonArticleAdd(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      ),
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddBlogPost(),
          ),
        )
      },
      child: const Text("Article Add"),
    );
  }

  // ----------------------
  // Search Bar Animated
  // ----------------------
  AnimatedContainer _buildSearchBar(BuildContext context) {
    return AnimatedContainer(
      width: isSearchBarVisible ? 200 : 0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: isSearchBarVisible
          ? Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    articleFunctionality.searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search blog posts...',
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  // ----------------------
  // Floating Buttons
  // ----------------------
  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      foregroundColor: Theme.of(context).colorScheme.background,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddBlogPost(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  // ----------------------
  // Body of the Widget
  // ----------------------
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: articleFunctionality.getBlogPosts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorWidget();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget();
        }

        if (snapshot.data!.docs.isEmpty) {
          return _buildEmptyWidget(context);
        }

        return _buildBlogPostsList(context, snapshot);
      },
    );
  }

  // ----------------------
  // Error Handelling Widget
  // ----------------------
  Widget _buildErrorWidget() {
    return Center(
      child: Lottie.asset('assets/animation/datanotfound.json'),
    );
  }

  // ----------------------
  // Loading Widget
  // ----------------------
  Widget _buildLoadingWidget() {
    return Center(
      child: Lottie.asset('assets/animation/loader.json'),
    );
  }

  // ----------------------
  // Empty Widget
  // ----------------------
  Widget _buildEmptyWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Lottie.asset('assets/animation/datanotfound.json'),
            const SizedBox(height: 10),
            StyledText(
              text: "Sorry!! No search results found. ",
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              textAlign: TextAlign.center,
              bold: true,
            )
          ],
        ),
      ),
    );
  }

  // ----------------------
  // List Blog Post
  // ----------------------
  Widget _buildBlogPostsList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map(
            (DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              BlogPosModel blogPost = BlogPosModel.fromMap(data);
              // ----------------------
              // Blog Post Card Widgets
              // ----------------------
              return _buildBlogPostCard(context, document, blogPost);
            },
          ).toList(),
        ),
      ),
    );
  }

  // ----------------------
  // Cards Widget
  // ----------------------
  Card _buildBlogPostCard(
      BuildContext context, DocumentSnapshot document, BlogPosModel blogPost) {
    return Card(
      child: ListTile(
        // ----------------------
        // Title
        // ----------------------
        title: _buildBlogPostTitle(blogPost),
        // ----------------------
        // Subtitle
        // ----------------------
        subtitle: _buildBlogPostSubtitle(context, blogPost),
        // ----------------------
        // Tags
        // ----------------------
        trailing: _buildBlogPostActions(context, document, blogPost),
      ),
    );
  }

  // ----------------------
  // Title Widget
  // ----------------------
  Padding _buildBlogPostTitle(BlogPosModel blogPost) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: StyledText(
        text: "Title: ${blogPost.title}",
        fontSize: 18,
        bold: false,
        boldWords: const ["Title:"],
      ),
    );
  }

  // ----------------------
  //  Main Detail Widget
  // ----------------------
  Column _buildBlogPostSubtitle(BuildContext context, BlogPosModel blogPost) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ----------------------
        // Desc Widget
        // ----------------------
        _buildBlogPostDescription(blogPost),
        // ----------------------
        // Author Widget
        // ----------------------
        _buildBlogPostAuthor(blogPost),
        // ----------------------
        // Tags
        // ----------------------
        _buildBlogPostTags(context, blogPost),
      ],
    );
  }

  // ----------------------------
  //  Blog Deacption: Sub Title
  // ----------------------------
  Padding _buildBlogPostDescription(BlogPosModel blogPost) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: StyledText(
        text: "Blog Description: ${blogPost.subTitle}",
        fontSize: 15,
        bold: false,
        boldWords: const ["Blog Description:"],
      ),
    );
  }

  // ----------------------------
  //  Blog Deacption: Author
  // ----------------------------
  Padding _buildBlogPostAuthor(BlogPosModel blogPost) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: StyledText(
        text: "Author: ${blogPost.author}",
        fontSize: 13,
        bold: false,
        boldWords: const ["Author:"],
      ),
    );
  }

  // ----------------------------
  //  Blog Deacption: tags
  // ----------------------------
  Wrap _buildBlogPostTags(BuildContext context, BlogPosModel blogPost) {
    return Wrap(
      runSpacing: 4.0,
      spacing: 8.0,
      children: blogPost.tags.map((tag) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Chip(
            label: Text(tag),
          ),
        );
      }).toList(),
    );
  }

  // ----------------------------
  //  Blog Post Action Buttons
  // ----------------------------
  Row _buildBlogPostActions(
      BuildContext context, DocumentSnapshot document, BlogPosModel blogPost) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // ----------------------------
        //  Blog Post: Edit Button
        // ----------------------------
        _buildEditButton(context, document),
        // --------------------------------
        //  Blog post Enable and Disable
        // --------------------------------
        _buildVisibilityButton(document, blogPost),
        // ----------------------------
        //  Blog Post Delete Button
        // ----------------------------
        _buildDeleteButton(context, document),
      ],
    );
  }

  // -----------------------------------
  //  Blog Post: Edit Button Function
  // -----------------------------------
  IconButton _buildEditButton(BuildContext context, DocumentSnapshot document) {
    return IconButton(
      icon: const Icon(
        Icons.edit,
        color: Colors.blue,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateBlogPost(document.id),
          ),
        );
      },
    );
  }

  // -----------------------------------------
  //  Blog Post: Enable and Disable Function
  // -----------------------------------------
  IconButton _buildVisibilityButton(
      DocumentSnapshot document, BlogPosModel blogPost) {
    return IconButton(
      icon: Icon(
        blogPost.isEnabled ? Icons.visibility : Icons.visibility_off,
        color: blogPost.isEnabled ? Colors.green : Colors.grey,
      ),
      onPressed: () async {
        await articleFunctionality.updateBlogPostStatus(
            document.id, !blogPost.isEnabled);
      },
    );
  }

  // -----------------------------------
  //  Blog Post: Delete Function
  // -----------------------------------
  IconButton _buildDeleteButton(
      BuildContext context, DocumentSnapshot document) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: StyledText(
              text: 'Delete Blog Post',
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            content: StyledText(
              text: 'Are you sure you want to delete this blog post?',
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
            actions: <Widget>[
              TextButton(
                child: StyledText(
                  text: 'Cancel',
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const StyledText(
                  text: 'Delete',
                  fontSize: 14,
                  color: Colors.red,
                ),
                onPressed: () async {
                  await articleFunctionality.deleteBlogPost(document.id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

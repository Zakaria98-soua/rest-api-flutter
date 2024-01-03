import 'package:flutter/material.dart';
import 'api_service.dart';
import 'post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      List<Post> fetchedPosts = await apiService.fetchPosts();
      setState(() {
        posts = fetchedPosts;
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  Future<void> createPost() async {
    try {
      Post newPost = Post(id: 0, title: 'New Post', body: 'This is a new post');

      await apiService.createPost(newPost);

      await fetchPosts();
    } catch (e) {
      print('Error creating post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API Project'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].body),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createPost(); 
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

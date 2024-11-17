import 'package:api_data/models/post.dart';
import 'package:api_data/sevices/remote_services.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget{
  const ProductListScreen({Key? key}):super(key: key);
  @override
  _ProductListScreenState createState()=> _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen>{
    List<Post>? posts;
    var isLoaded = false;
    @override
  void initState() {
    super.initState();
    getData();
  }
  getData() async{
    posts = await RemoteServices().getPosts();
    if(posts != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
          centerTitle: true,
          actions: [
            Icon(Icons.shopping_bag_outlined),
            SizedBox(width: 40.0)
          ],
            
        ),
        body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index){
              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 253, 166, 36),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(posts![index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
                          
                          Text(posts![index].body?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
}
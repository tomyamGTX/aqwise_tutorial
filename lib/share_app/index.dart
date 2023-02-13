
import 'package:aqwise_stripe_payment/share_app/share_utils.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  var image =
      'https://aqwise.my/wp-content/uploads/2020/11/cropped-aqwiselogo3.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Share App'),
          actions: [
            IconButton(
                onPressed: () async {
                  XFile fileForShare = await fileFromImageUrl(image, 'share');
                  await Share.shareXFiles(
                    [fileForShare],
                    text: 'Great picture. Check it now at url $image',
                  );
                },
                icon: const Icon(Icons.share))
          ],
        ),
        body: const Placeholder());
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNewUser', false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        children: const [
          OnboardingStep(
            title: 'DAILY FAMILY PRAYER\nCOMPANION 2025',
            description1: 'COMPILED BY:\nELDER SAMSON AMEH\nOPALUWAH',
            description2:
                'All Scriptures are in the King James Version (KJV) New International Version (NIV) Amplified Bible and the New King James Version (NKJV).',
          ),
          OnboardingStep(
            title: 'HOW TO USE THIS DEVOTIONAL',
            description1:
                'A Devotional is a guide to hearing from God. It is a resource material for prayer, bible study for personal or collective quiet time for the family altar or the Church. By using a devotional, thoughts are guided, perspectives explained, and revelations received on issues. However, although issues and topics in this devotional are provided in this devotional, the reader is at liberty to explore beyond the brief exhortations given here in. The users of this devotional should therefore study more than is briefly provided here and prayerfully listen to what God is saying to the individual, family, church, nation, or the world at large. This devotional is also not a substitute for personal search of the scriptures for spiritual growth. Every believer is instructed to study the word of God as a guiding principle for spiritual maturity, away from the limitations of the issues provide in all devotionals. It is the prayer of the writer of this devotional, though, that it will guide and lead the reader especially families into a deeper study of the Word of God.',
            description2: '',
          ),
          OnboardingStep(
            title: 'ACKNOWLEDGEMENT',
            description1:
                'To God be the glory for another edition of the Daily Family Prayer Companion. This initiative which started by God’s prompting to support the family altar with suggested prayer points to enrich the prayer life of families is finding acceptance generally as a family devotional. This being the second edition, it is proper and fitting to give thanks to God for the opportunity to be of use in His hands. The enabling environment created by my local assembly, ECWA Church, Wuse 2, Abuja Nigeria, has helped in exposing the day-to-day challenges that families face thus providing the direction for prayers at the family altars where this devotional is expected to be used. My sincere thanks and appreciation go to the Senior Pastor, Reverend Nash Azaki PhD, and His Associate Pastors, Reverend Chukwuemeka Okonkwo, Reverend Bulus Bala & Pastor Destiny Aguma for their oversight of the Lord’s flock and contributions to this devotional. When the idea of the first edition was mooted, the Men Fellowship of ECWA Church, Wuse 2, Abuja, to whom I am greatly indebted for their constant support, took the issues of producing the devotionals for free distribution. May God reward and bless each member of the fellowship abundantly. The Lord has raised for Himself many prayer warriors to intercede on behalf of families. The obedience of these to the Lord’s instructions has helped to make this devotional rich and to encompass most aspects of a typical family life. These servants of the Lord in no particular order are: Elder Ifeanyi Odedo, Elder Dan Alumka, Elder Ehwan Usman Rebo, Mrs Flask Ahmed, Mrs Margareth Banta, Mrs Sarah Oyaghire, Mrs Mary Aduwak, Mrs Safiya Tamanua and a host of others who conributed directly or indirectly to this devotional. I am full of gratitude to all of them. Barrister Silas Ayuba, my publications executive, did a marvelous work collating, coordinating and compiling the devotional. Emmanuel Neple had the responsibility of putting the devotional in an electronic format for easy distribution and access beyond boundaries. I am deeply appreciative and may God reward your labour of love. My dear wife, Mrs Hannah Ede Opaluwah whose invaluable contribution to this work cannot be quantified deserves not just appreciation but prayers for more grace. May God continue to bless you. Finally, to all above and every reader or participant at the family altar where this devotional is used, I pray for showers of God’s blessing upon you in the year 2025.',
            description2:
                'SAMSON AMEH OPALUWAH23RD\nDECEMBER 2024 @ NOTTINGHAM UK',
          ),
        ],
      ),
      bottomSheet: Container(
  color: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
  child: SizedBox(
    width: double.infinity,
    child: _currentPage < 2
        ? ElevatedButton(
            onPressed: _goToNextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 95, 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // No border radius for full-width look
              ),
            ),
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white), // White text color
            ),
          )
        : ElevatedButton(
            onPressed: _finishOnboarding,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 95, 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0), // No border radius for full-width look
              ),
            ),
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white), // White text color
            ),
          ),
  ),
),

    );
  }
}

class OnboardingStep extends StatelessWidget {
  final String title;
  final String description1;
  final String description2;

  const OnboardingStep({
    required this.title,
    required this.description1,
    required this.description2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 85.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontFamily: 'Roboto_Condensed',
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 7, 95, 22), // Green color
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              description1,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 7, 95, 22),
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: size.height * 0.20),
            Text(
              description2,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 7, 95, 22),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

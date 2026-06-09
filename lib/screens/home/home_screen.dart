import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const getAmount = '₹ 24,850';
    const getPeople = 'from 12 people';
    const giveAmount = '₹ 18,420';
    const givePeople = 'to 7 people';
    const netBalance = '₹ 6,430';

    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                ),
                Center(
                  child: Text(
                    'Ledjify',
                    style: GoogleFonts.outfit(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      height: 1,
                      letterSpacing: -1.5,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SummaryCard(
              getAmount: getAmount,
              getPeople: getPeople,
              giveAmount: giveAmount,
              givePeople: givePeople,
              netBalance: netBalance,
            ),
          ),
        ],
      ),
    );
  }
}
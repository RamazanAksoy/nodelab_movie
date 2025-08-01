// lib/feature/jeton/view/jeton_teklif_sheet.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/constants/image/images.dart';

class JetonTeklifSheet extends StatelessWidget {
  const JetonTeklifSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildGlow(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeaderText(),
              const SizedBox(height: 20),
              _buildBonusSection(),
              const SizedBox(height: 20),
              _buildUnlockText(),
              const SizedBox(height: 20),
              _buildJetonCards(),
              const SizedBox(height: 24),
              _buildSeeAllButton(),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlow() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      height: 120,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [BoxShadow(color: const Color(0xFFE50914).withOpacity(0.2), spreadRadius: 30, blurRadius: 100, offset: const Offset(0, 0))],
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Column(
      children: [
        Text(
          'jeton.limited_offer'.tr(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          'jeton.limited_description'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildBonusSection() {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        children: [
          Text(
            'jeton.bonus_title'.tr(),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BonusWidget(imageUrl: AppImages.instance.pro1, title: 'jeton.bonus1'.tr()),
              BonusWidget(imageUrl: AppImages.instance.pro2, title: 'jeton.bonus2'.tr()),
              BonusWidget(imageUrl: AppImages.instance.pro3, title: 'jeton.bonus3'.tr()),
              BonusWidget(imageUrl: AppImages.instance.pro4, title: 'jeton.bonus4'.tr()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockText() {
    return Text('jeton.unlock_text'.tr(), style: TextStyle(fontSize: 14, color: Colors.white));
  }

  Widget _buildJetonCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        JetonCard(
          bonus: '+10%',
          eski: '200',
          yeni: '330',
          fiyat: '₺99,99',
          imageUrl: AppImages.instance.coin10,
          titleImageUrl: AppImages.instance.frame10,
        ),
        JetonCard(
          bonus: '+70%',
          eski: '2.000',
          yeni: '3.375',
          fiyat: '₺799,99',
          imageUrl: AppImages.instance.coin70,
          titleImageUrl: AppImages.instance.frame70,
        ),
        JetonCard(
          bonus: '+35%',
          eski: '1.000',
          yeni: '1.350',
          fiyat: '₺399,99',
          imageUrl: AppImages.instance.coin35,
          titleImageUrl: AppImages.instance.frame35,
        ),
      ],
    );
  }

  Widget _buildSeeAllButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE50914),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {},
      child: Text(
        'jeton.see_all'.tr(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BonusWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  const BonusWidget({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(image: AssetImage(AppImages.instance.ellipse), fit: BoxFit.cover),
          ),
          child: Image.asset(imageUrl),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class JetonCard extends StatelessWidget {
  final String bonus;
  final String eski;
  final String yeni;
  final String fiyat;
  final String imageUrl;
  final String titleImageUrl;

  const JetonCard({
    super.key,
    required this.bonus,
    required this.eski,
    required this.yeni,
    required this.fiyat,
    required this.imageUrl,
    required this.titleImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 24.h,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        eski,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        yeni,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Jeton',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white30),
                  Column(
                    children: [
                      Text(
                        fiyat,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                      Text('jeton.per_week'.tr(), style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -10,
              left: 7.w,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(titleImageUrl), fit: BoxFit.cover),
                ),
                child: Text(bonus, style: const TextStyle(fontSize: 15, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

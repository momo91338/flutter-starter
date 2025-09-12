import 'package:flutter/material.dart';
import 'package:privy_flutter/privy_flutter.dart';

/// Widget that displays all linked accounts for a Privy user
class LinkedAccountsWidget extends StatelessWidget {
  final PrivyUser user;

  const LinkedAccountsWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Linked Accounts", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        if (user.linkedAccounts.isEmpty)
          const Text("No linked accounts", style: TextStyle(color: Colors.grey))
        else
          ...user.linkedAccounts.map((account) => _buildAccountTile(account)),
      ],
    );
  }

  Widget _buildAccountTile(LinkedAccounts account) {
    if (account is EmailAccount) {
      return ListTile(
        leading: const Icon(Icons.email),
        title: const Text("Email Account"),
        subtitle: Text(account.emailAddress),
        dense: true,
      );
    } else if (account is PhoneNumberAccount) {
      return ListTile(
        leading: const Icon(Icons.phone),
        title: const Text("Phone Number"),
        subtitle: Text(account.phoneNumber),
        dense: true,
      );
    } else if (account is GoogleOAuthAccount) {
      return ListTile(
        leading: const Icon(Icons.g_mobiledata),
        title: const Text("Google Account"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (account.name != null) Text("Name: ${account.name}"),
            Text("Email: ${account.email}"),
            Text("Subject: ${account.subject}"),
          ],
        ),
        dense: true,
      );
    } else if (account is TwitterOAuthAccount) {
      return ListTile(
        leading: const Icon(Icons.alternate_email),
        title: const Text("Twitter Account"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (account.name != null) Text("Name: ${account.name}"),
            if (account.username != null)
              Text("Username: @${account.username}"),
            Text("Subject: ${account.subject}"),
          ],
        ),
        dense: true,
      );
    } else if (account is DiscordOAuthAccount) {
      return ListTile(
        leading: const Icon(Icons.chat),
        title: const Text("Discord Account"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (account.username != null) Text("Username: ${account.username}"),
            if (account.email != null) Text("Email: ${account.email}"),
            Text("Subject: ${account.subject}"),
          ],
        ),
        dense: true,
      );
    } else if (account is EmbeddedEthereumWalletAccount ||
        account is EmbeddedSolanaWalletAccount) {
      // Skip wallet accounts as they'll be shown in their own section
      return const SizedBox.shrink();
    } else {
      // Generic account tile for other account types
      return ListTile(
        leading: const Icon(Icons.account_circle),
        title: Text("${account.type.toUpperCase()} Account"),
        dense: true,
      );
    }
  }
}

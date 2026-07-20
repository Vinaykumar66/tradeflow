import 'package:supabase_flutter/supabase_flutter.dart';

// The Supabase client - equivalent of:
//   Firebase: FirebaseFirestore.instance + FirebaseAuth.instance
//   Supabase: ONE client for everything
SupabaseClient get supabase => Supabase.instance.client;

// Convenience accessors
// supabaseAuth  = Supabase auth service
// supabaseDB    = query tables (from, select, insert, update, delete)
// supabaseStore = file storage

/*Temporarily commented to reduce Supabase dependency
GoTrueClient get supabaseAuth => supabase.auth;

SupabaseQueryBuilder Function(String) get supabaseDB =>
    (table) => supabase.from(table);
SupabaseStorageClient get supabaseStore => supabase.storage;

Temporarily commented to reduce Supabase dependency*/

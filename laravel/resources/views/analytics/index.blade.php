@extends('layouts.app')

@section('content')
    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900 dark:text-gray-100">
                    <h2 class="text-xl font-bold mb-4">Analytics</h2>
                    <table class="min-w-full text-sm">
                        <thead>
                            <tr>
                                <th class="px-4 py-2 text-left">Page</th>
                                <th class="px-4 py-2 text-left">User ID</th>
                                <th class="px-4 py-2 text-left">Timestamp</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($analytics as $entry)
                                <tr>
                                    <td class="border px-4 py-2">{{ $entry->page }}</td>
                                    <td class="border px-4 py-2">{{ $entry->user_id ?? 'guest' }}</td>
                                    <td class="border px-4 py-2">{{ $entry->created_at }}</td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
@endsection

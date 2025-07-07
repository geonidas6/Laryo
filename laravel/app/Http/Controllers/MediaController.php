<?php

namespace App\Http\Controllers;

use App\Models\Media;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Symfony\Component\HttpFoundation\Response;

class MediaController extends Controller
{
    public function store(Request $request)
    {
        $request->validate(['file' => ['required', 'file']]);

        $file = $request->file('file');
        $disk = config('filesystems.default');
        $path = $file->store('media', ['disk' => $disk]);

        $media = Media::create([
            'original_name' => $file->getClientOriginalName(),
            'path' => $path,
            'disk' => $disk,
            'mime_type' => $file->getMimeType(),
            'size' => $file->getSize(),
        ]);

        return response()->json($media, Response::HTTP_CREATED);
    }

    public function show(Media $media)
    {
        if (!Storage::disk($media->disk)->exists($media->path)) {
            abort(404);
        }

        return Storage::disk($media->disk)->response($media->path, $media->original_name);
    }
}

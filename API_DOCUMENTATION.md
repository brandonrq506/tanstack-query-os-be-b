# Movies API Documentation

## Endpoints

### GET /v1/movies

Retrieve a list of movies with optional filtering and sorting using nested parameters.

#### Request Body Structure

The API expects nested `filter` and `sort` objects in the request parameters:

```typescript
type MoviePreview = {
  id: number;
  title: string;
  thumbnail_url: string;
};

type MovieApiFilters = {
  title: string;
  genre_id: number;
  is_featured: boolean;
  duration_secs: number;
  published_at: string;
  created_at: string;
  updated_at: string;
};

type SortParams = {
  sort_by: string;
  sort_order: "asc" | "desc";
};

type MovieOptions = {
  filter?: Partial<MovieApiFilters>;
  sort?: Partial<SortParams>;
};
```

#### Query Parameters

**Filtering** (`filter` object):
- `title` (string, optional): Filter movies by title (case-insensitive partial match)
- `genre_id` (integer, optional): Filter movies by genre ID
- `is_featured` (boolean, optional): Filter movies by featured status (true/false)
- `duration_secs` (integer, optional): Filter movies by duration
- `published_at` (string, optional): Filter movies by publish date
- `created_at` (string, optional): Filter movies by creation date
- `updated_at` (string, optional): Filter movies by last update date

**Sorting** (`sort` object):
- `sort_by` (string, optional): Field to sort by
  - Allowed values: `title`, `duration_secs`, `genre_name`, `published_at`, `created_at`, `updated_at`
  - Default: `created_at`
- `sort_order` (string, optional): Sort direction
  - Allowed values: `asc`, `desc`
  - Default: `desc`

#### Examples

```bash
# Basic request
GET /v1/movies

# Filter by title
GET /v1/movies?filter[title]=action

# Filter by genre and featured status
GET /v1/movies?filter[genre_id]=1&filter[is_featured]=true

# Sort by title ascending
GET /v1/movies?sort[sort_by]=title&sort[sort_order]=asc

# Sort by genre name descending
GET /v1/movies?sort[sort_by]=genre_name&sort[sort_order]=desc

# Combined filtering and sorting
GET /v1/movies?filter[title]=spider&filter[genre_id]=1&sort[sort_by]=duration_secs&sort[sort_order]=asc
```

#### Frontend Usage Example

```typescript
const movieOptions: MovieOptions = {
  filter: {
    title: "spider",
    genre_id: 1,
    is_featured: true
  },
  sort: {
    sort_by: "duration_secs",
    sort_order: "asc"
  }
};

const { data } = await apiV1.get<MoviePreview[]>(MOVIES_ENDPOINT, {
  signal,
  params: movieOptions
});
```

#### Response

Returns an array of movie previews. Each movie preview contains only essential information for listing purposes:

```json
[
  {
    "id": 1,
    "title": "Spider-Man",
    "thumbnail_url": "https://example.com/spider-man.jpg"
  },
  {
    "id": 2,
    "title": "The Dark Knight", 
    "thumbnail_url": "https://example.com/dark-knight.jpg"
  }
]
```

**Note**: This endpoint returns a simplified preview format using `MoviePreviewSerializer`. For complete movie details including synopsis, trailer URL, duration, genre information, and metadata, use the individual movie endpoint (`GET /v1/movies/:id`).

### GET /v1/movies/featured

Retrieve featured movies that are published. Supports the same filtering and sorting parameters as the main index endpoint.

#### Response

Returns an array of featured movie previews in the same format as the main index endpoint:

```json
[
  {
    "id": 1,
    "title": "Spider-Man",
    "thumbnail_url": "https://example.com/spider-man.jpg"
  }
]
```

### GET /v1/movies/coming_soon

Retrieve movies that are not yet published (coming soon). Supports the same filtering and sorting parameters as the main index endpoint.

#### Response

Returns an array of upcoming movie previews in the same format as the main index endpoint:

```json
[
  {
    "id": 4,
    "title": "Future Film",
    "thumbnail_url": "https://example.com/future.jpg"
  }
]
```

### GET /v1/movies/:id

Retrieve a specific movie by ID. Returns the complete movie object with all details.

#### Response

```json
{
  "id": 1,
  "title": "Spider-Man",
  "sinopsis": "A young man gains spider-like abilities...",
  "trailer_url": "https://example.com/trailer.mp4",
  "thumbnail_url": "https://example.com/spider-man.jpg",
  "duration_secs": 7200,
  "genre_id": 1,
  "is_featured": true,
  "published_at": "2023-07-15T10:00:00.000Z",
  "created_at": "2023-07-01T10:00:00.000Z",
  "updated_at": "2023-07-01T10:00:00.000Z"
}
```

**Note**: Unlike the list endpoints which return `MoviePreview` objects, this endpoint returns the complete `Movie` object with all attributes including synopsis, trailer URL, duration, and timestamps.

## Error Handling

The API returns appropriate HTTP status codes:

- `200 OK`: Successful request
- `404 Not Found`: Movie not found
- `422 Unprocessable Entity`: Invalid parameters

Invalid filter or sort parameters are ignored and default values are used instead.

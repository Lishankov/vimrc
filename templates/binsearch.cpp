int64_t binsearch(int64_t left, int64_t right, auto predicate) {
    while (left < right) {
        int64_t mid = (left>>1) + (right>>1);
        if (predicate(mid)) { left = mid + 1; }
        else                { right = mid; }
    }

    return left;
}

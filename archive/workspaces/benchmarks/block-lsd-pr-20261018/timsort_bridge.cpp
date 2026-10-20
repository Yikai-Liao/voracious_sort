// The upstream TimSort header is used without changes (v3.0.1).
#include <gfx/timsort.hpp>
#include <bit>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <new>

#ifdef TRACK_ALLOC
extern "C" void benchmark_cpp_allocate(std::size_t);
extern "C" void benchmark_cpp_deallocate(std::size_t);
struct alignas(std::max_align_t) Header { std::size_t requested; };
void* operator new(std::size_t n) {
    auto* p = static_cast<Header*>(std::malloc(sizeof(Header) + n));
    if (!p) throw std::bad_alloc();
    p->requested = n;
    benchmark_cpp_allocate(n);
    return p + 1;
}
void operator delete(void* q) noexcept {
    if (!q) return;
    auto* p = static_cast<Header*>(q) - 1;
    benchmark_cpp_deallocate(p->requested);
    std::free(p);
}
void operator delete(void* q, std::size_t) noexcept { ::operator delete(q); }
void* operator new[](std::size_t n) { return ::operator new(n); }
void operator delete[](void* q) noexcept { ::operator delete(q); }
void operator delete[](void* q, std::size_t) noexcept { ::operator delete(q); }
#endif

template<class T> auto key(T x) { return x; }
std::uint32_t key(float x) {
    auto u = std::bit_cast<std::uint32_t>(x);
    return u ^ ((u >> 31) ? UINT32_MAX : UINT32_C(0x80000000));
}
std::uint64_t key(double x) {
    auto u = std::bit_cast<std::uint64_t>(x);
    return u ^ ((u >> 63) ? UINT64_MAX : UINT64_C(0x8000000000000000));
}
template<std::size_t N> struct Record {
    std::uint64_t key, id, payload[N];
};
template<std::size_t N> std::uint64_t key(const Record<N>& x) { return x.key; }
static_assert(sizeof(Record<2>) == 32 && sizeof(Record<14>) == 128);

template<class T> void run(void* data, std::size_t n) {
    auto* a = static_cast<T*>(data);
    gfx::timsort(a, a+n, [](const T& x, const T& y) { return key(x) < key(y); });
}
extern "C" void benchmark_timsort(void* data, std::size_t n, unsigned kind) {
    switch(kind) {
        case 0: run<std::uint32_t>(data,n); break;
        case 1: run<std::uint64_t>(data,n); break;
        case 2: run<unsigned __int128>(data,n); break;
        case 3: run<std::int32_t>(data,n); break;
        case 4: run<std::int64_t>(data,n); break;
        case 5: run<float>(data,n); break;
        case 6: run<double>(data,n); break;
        case 7: run<Record<2>>(data,n); break;
        case 8: run<Record<14>>(data,n); break;
        default: std::abort();
    }
}

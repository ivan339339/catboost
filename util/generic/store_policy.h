#pragma once

#include <utility>
#include "ptr.h"

template <class TBase, class TCounter>
struct TWithRefCount: public TBase, public TRefCounted<TWithRefCount<TBase, TCounter>, TCounter> {
    template <typename... Args>
    inline TWithRefCount(Args&&... args)
        : TBase(std::forward<Args>(args)...)
    {
    }
};

template <class T>
struct TPtrPolicy {
    inline TPtrPolicy(T* t)
        : T_(t)
    {
    }

    inline T* Ptr() noexcept {
        return T_;
    }

    inline const T* Ptr() const noexcept {
        return T_;
    }

    T* T_;
};

template <class T>
struct TEmbedPolicy {
    template <typename... Args>
    inline TEmbedPolicy(Args&&... args)
        : T_(std::forward<Args>(args)...)
    {
    }

    inline T* Ptr() noexcept {
        return &T_;
    }

    inline const T* Ptr() const noexcept {
        return &T_;
    }

    T T_;
};

template <class T, class TCounter>
struct TRefPolicy {
    using THelper = TWithRefCount<T, TCounter>;

    template <typename... Args>
    inline TRefPolicy(Args&&... args)
        : T_(new THelper(std::forward<Args>(args)...))
    {
    }

    inline T* Ptr() noexcept {
        return T_.Get();
    }

    inline const T* Ptr() const noexcept {
        return T_.Get();
    }

    TIntrusivePtr<THelper> T_;
};


template <class TRefOrObject, bool IsReference = std::is_reference<TRefOrObject>::value>
struct TAutoEmbedOrPtrPolicy;

template <class TReference>
struct TAutoEmbedOrPtrPolicy<TReference, true> : TPtrPolicy<typename std::remove_reference<TReference>::type> {
    using TObject = typename std::remove_reference<TReference>::type;
    using TObjectStorage = TObject*;

    TAutoEmbedOrPtrPolicy(TReference& reference)
        : TPtrPolicy<TObject>(&reference)
    {
    }
};

template <class TObject_>
struct TAutoEmbedOrPtrPolicy<TObject_, false> : TEmbedPolicy<TObject_> {
    using TObject = TObject_;
    using TObjectStorage = TObject;

    TAutoEmbedOrPtrPolicy(TObject& object)
        : TEmbedPolicy<TObject>(std::move(object))
    {
    }

    TAutoEmbedOrPtrPolicy(TObject&& object)
        : TEmbedPolicy<TObject>(std::move(object))
    {
    }
};

template <class T>
using TAtomicRefPolicy = TRefPolicy<T, TAtomicCounter>;

template <class T>
using TSimpleRefPolicy = TRefPolicy<T, TSimpleCounter>;

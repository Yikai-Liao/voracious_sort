; ModuleID = '/tmp/radsort-review-20261014/radixsort_permuted.c'
source_filename = "/tmp/radsort-review-20261014/radixsort_permuted.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.radixsort_impl = type { ptr, ptr, ptr }
%struct.bucket = type { ptr, ptr }

@.str = private unnamed_addr constant [18 x i8] c"sorter_initialize\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"permuted\00", align 1
@clang_permuted_impl = dso_local local_unnamed_addr constant %struct.radixsort_impl { ptr @.str.1, ptr @clang_permuted_sort, ptr @always_supported }, align 8

; Function Attrs: nounwind sspstrong uwtable
define dso_local void @clang_permuted_sort(ptr noundef %0, i64 noundef %1) #0 {
  %3 = icmp eq i64 %1, 0
  br i1 %3, label %386, label %4

4:                                                ; preds = %2
  %5 = tail call noalias dereferenceable_or_null(2099248) ptr @malloc(i64 noundef 2099248) #10
  %6 = lshr i64 %1, 9
  %7 = add nuw nsw i64 %6, 512
  %8 = tail call noalias ptr @calloc(i64 noundef 4, i64 noundef %7) #11
  %9 = tail call noalias ptr @calloc(i64 noundef 4, i64 noundef %7) #11
  %10 = tail call noalias ptr @calloc(i64 noundef 1, i64 noundef %7) #11
  %11 = icmp eq ptr %5, null
  %12 = icmp eq ptr %8, null
  %13 = or i1 %11, %12
  %14 = icmp eq ptr %9, null
  %15 = or i1 %13, %14
  %16 = icmp eq ptr %10, null
  %17 = or i1 %15, %16
  br i1 %17, label %188, label %18

18:                                               ; preds = %4
  store ptr %0, ptr %5, align 8, !tbaa !9
  %19 = getelementptr inbounds nuw i8, ptr %5, i64 8
  store i64 %1, ptr %19, align 8, !tbaa !15
  %20 = getelementptr inbounds nuw i8, ptr %5, i64 24
  store ptr %8, ptr %20, align 8, !tbaa !16
  %21 = getelementptr inbounds nuw i8, ptr %5, i64 32
  store ptr %9, ptr %21, align 8, !tbaa !17
  %22 = getelementptr inbounds nuw i8, ptr %5, i64 40
  store ptr %10, ptr %22, align 8, !tbaa !18
  %23 = add nuw nsw i64 %6, 257
  %24 = getelementptr inbounds nuw i8, ptr %5, i64 16
  store i64 %23, ptr %24, align 8, !tbaa !19
  %25 = getelementptr inbounds nuw i8, ptr %8, i64 64
  %26 = getelementptr inbounds nuw i8, ptr %8, i64 128
  %27 = getelementptr inbounds nuw i8, ptr %8, i64 192
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>, ptr %8, align 4, !tbaa !20
  store <16 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>, ptr %25, align 4, !tbaa !20
  store <16 x i32> <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47>, ptr %26, align 4, !tbaa !20
  store <16 x i32> <i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>, ptr %27, align 4, !tbaa !20
  %28 = getelementptr inbounds nuw i8, ptr %8, i64 256
  %29 = getelementptr inbounds nuw i8, ptr %8, i64 320
  %30 = getelementptr inbounds nuw i8, ptr %8, i64 384
  %31 = getelementptr inbounds nuw i8, ptr %8, i64 448
  store <16 x i32> <i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79>, ptr %28, align 4, !tbaa !20
  store <16 x i32> <i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95>, ptr %29, align 4, !tbaa !20
  store <16 x i32> <i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111>, ptr %30, align 4, !tbaa !20
  store <16 x i32> <i32 112, i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119, i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127>, ptr %31, align 4, !tbaa !20
  %32 = getelementptr inbounds nuw i8, ptr %8, i64 512
  %33 = getelementptr inbounds nuw i8, ptr %8, i64 576
  %34 = getelementptr inbounds nuw i8, ptr %8, i64 640
  %35 = getelementptr inbounds nuw i8, ptr %8, i64 704
  store <16 x i32> <i32 128, i32 129, i32 130, i32 131, i32 132, i32 133, i32 134, i32 135, i32 136, i32 137, i32 138, i32 139, i32 140, i32 141, i32 142, i32 143>, ptr %32, align 4, !tbaa !20
  store <16 x i32> <i32 144, i32 145, i32 146, i32 147, i32 148, i32 149, i32 150, i32 151, i32 152, i32 153, i32 154, i32 155, i32 156, i32 157, i32 158, i32 159>, ptr %33, align 4, !tbaa !20
  store <16 x i32> <i32 160, i32 161, i32 162, i32 163, i32 164, i32 165, i32 166, i32 167, i32 168, i32 169, i32 170, i32 171, i32 172, i32 173, i32 174, i32 175>, ptr %34, align 4, !tbaa !20
  store <16 x i32> <i32 176, i32 177, i32 178, i32 179, i32 180, i32 181, i32 182, i32 183, i32 184, i32 185, i32 186, i32 187, i32 188, i32 189, i32 190, i32 191>, ptr %35, align 4, !tbaa !20
  %36 = getelementptr inbounds nuw i8, ptr %8, i64 768
  %37 = getelementptr inbounds nuw i8, ptr %8, i64 832
  %38 = getelementptr inbounds nuw i8, ptr %8, i64 896
  %39 = getelementptr inbounds nuw i8, ptr %8, i64 960
  store <16 x i32> <i32 192, i32 193, i32 194, i32 195, i32 196, i32 197, i32 198, i32 199, i32 200, i32 201, i32 202, i32 203, i32 204, i32 205, i32 206, i32 207>, ptr %36, align 4, !tbaa !20
  store <16 x i32> <i32 208, i32 209, i32 210, i32 211, i32 212, i32 213, i32 214, i32 215, i32 216, i32 217, i32 218, i32 219, i32 220, i32 221, i32 222, i32 223>, ptr %37, align 4, !tbaa !20
  store <16 x i32> <i32 224, i32 225, i32 226, i32 227, i32 228, i32 229, i32 230, i32 231, i32 232, i32 233, i32 234, i32 235, i32 236, i32 237, i32 238, i32 239>, ptr %38, align 4, !tbaa !20
  store <16 x i32> <i32 240, i32 241, i32 242, i32 243, i32 244, i32 245, i32 246, i32 247, i32 248, i32 249, i32 250, i32 251, i32 252, i32 253, i32 254, i32 255>, ptr %39, align 4, !tbaa !20
  %40 = add nuw nsw i64 %6, 256
  %41 = icmp eq i64 %6, 0
  br i1 %41, label %91, label %42

42:                                               ; preds = %18
  %43 = icmp ult i64 %1, 4096
  br i1 %43, label %89, label %44

44:                                               ; preds = %42
  %45 = icmp ult i64 %1, 32768
  br i1 %45, label %69, label %46

46:                                               ; preds = %44
  %47 = and i64 %6, 36028797018963904
  %48 = add nuw nsw i64 %47, 256
  br label %49

49:                                               ; preds = %49, %46
  %50 = phi i64 [ 0, %46 ], [ %61, %49 ]
  %51 = phi <16 x i32> [ <i32 256, i32 257, i32 258, i32 259, i32 260, i32 261, i32 262, i32 263, i32 264, i32 265, i32 266, i32 267, i32 268, i32 269, i32 270, i32 271>, %46 ], [ %62, %49 ]
  %52 = add <16 x i32> %51, splat (i32 256)
  %53 = add <16 x i32> %51, splat (i32 272)
  %54 = add <16 x i32> %51, splat (i32 288)
  %55 = add <16 x i32> %51, splat (i32 304)
  %56 = getelementptr [4 x i8], ptr %8, i64 %50
  %57 = getelementptr i8, ptr %56, i64 1024
  %58 = getelementptr i8, ptr %56, i64 1088
  %59 = getelementptr i8, ptr %56, i64 1152
  %60 = getelementptr i8, ptr %56, i64 1216
  store <16 x i32> %52, ptr %57, align 4, !tbaa !20
  store <16 x i32> %53, ptr %58, align 4, !tbaa !20
  store <16 x i32> %54, ptr %59, align 4, !tbaa !20
  store <16 x i32> %55, ptr %60, align 4, !tbaa !20
  %61 = add nuw i64 %50, 64
  %62 = add <16 x i32> %51, splat (i32 64)
  %63 = icmp eq i64 %61, %47
  br i1 %63, label %64, label %49, !llvm.loop !21

64:                                               ; preds = %49
  %65 = icmp eq i64 %6, %47
  br i1 %65, label %91, label %66

66:                                               ; preds = %64
  %67 = and i64 %1, 28672
  %68 = icmp eq i64 %67, 0
  br i1 %68, label %89, label %69, !prof !25

69:                                               ; preds = %44, %66
  %70 = phi i64 [ %47, %66 ], [ 0, %44 ]
  %71 = phi i64 [ %48, %66 ], [ 256, %44 ]
  %72 = and i64 %6, 36028797018963960
  %73 = add nuw nsw i64 %72, 256
  %74 = trunc i64 %71 to i32
  %75 = insertelement <8 x i32> poison, i32 %74, i64 0
  %76 = shufflevector <8 x i32> %75, <8 x i32> poison, <8 x i32> zeroinitializer
  %77 = add <8 x i32> %76, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  br label %78

78:                                               ; preds = %78, %69
  %79 = phi i64 [ %70, %69 ], [ %84, %78 ]
  %80 = phi <8 x i32> [ %77, %69 ], [ %85, %78 ]
  %81 = add <8 x i32> %80, splat (i32 256)
  %82 = getelementptr [4 x i8], ptr %8, i64 %79
  %83 = getelementptr i8, ptr %82, i64 1024
  store <8 x i32> %81, ptr %83, align 4, !tbaa !20
  %84 = add nuw i64 %79, 8
  %85 = add <8 x i32> %80, splat (i32 8)
  %86 = icmp eq i64 %84, %72
  br i1 %86, label %87, label %78, !llvm.loop !26

87:                                               ; preds = %78
  %88 = icmp eq i64 %6, %72
  br i1 %88, label %91, label %89

89:                                               ; preds = %42, %66, %87
  %90 = phi i64 [ 256, %42 ], [ %48, %66 ], [ %73, %87 ]
  br label %181

91:                                               ; preds = %64, %87, %18, %181
  %92 = phi i64 [ 256, %18 ], [ %40, %64 ], [ %40, %87 ], [ %40, %181 ]
  %93 = insertelement <16 x i64> poison, i64 %92, i64 0
  %94 = shufflevector <16 x i64> %93, <16 x i64> poison, <16 x i32> zeroinitializer
  %95 = add nuw nsw <16 x i64> %94, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7, i64 8, i64 9, i64 10, i64 11, i64 12, i64 13, i64 14, i64 15>
  %96 = insertelement <16 x i64> poison, i64 %6, i64 0
  %97 = shufflevector <16 x i64> %96, <16 x i64> poison, <16 x i32> zeroinitializer
  %98 = add nuw <16 x i64> %94, <i64 16, i64 17, i64 18, i64 19, i64 20, i64 21, i64 22, i64 23, i64 24, i64 25, i64 26, i64 27, i64 28, i64 29, i64 30, i64 31>
  %99 = add nuw <16 x i64> %94, <i64 32, i64 33, i64 34, i64 35, i64 36, i64 37, i64 38, i64 39, i64 40, i64 41, i64 42, i64 43, i64 44, i64 45, i64 46, i64 47>
  %100 = add nuw <16 x i64> %94, <i64 48, i64 49, i64 50, i64 51, i64 52, i64 53, i64 54, i64 55, i64 56, i64 57, i64 58, i64 59, i64 60, i64 61, i64 62, i64 63>
  %101 = sub nuw nsw <16 x i64> %95, %97
  %102 = sub nuw nsw <16 x i64> %98, %97
  %103 = sub nuw nsw <16 x i64> %99, %97
  %104 = sub nuw nsw <16 x i64> %100, %97
  %105 = trunc <16 x i64> %101 to <16 x i32>
  %106 = trunc <16 x i64> %102 to <16 x i32>
  %107 = trunc <16 x i64> %103 to <16 x i32>
  %108 = trunc <16 x i64> %104 to <16 x i32>
  %109 = getelementptr [4 x i8], ptr %8, i64 %92
  %110 = getelementptr inbounds nuw i8, ptr %109, i64 64
  %111 = getelementptr inbounds nuw i8, ptr %109, i64 128
  %112 = getelementptr inbounds nuw i8, ptr %109, i64 192
  store <16 x i32> %105, ptr %109, align 4, !tbaa !20
  store <16 x i32> %106, ptr %110, align 4, !tbaa !20
  store <16 x i32> %107, ptr %111, align 4, !tbaa !20
  store <16 x i32> %108, ptr %112, align 4, !tbaa !20
  %113 = add nuw <16 x i64> %94, <i64 64, i64 65, i64 66, i64 67, i64 68, i64 69, i64 70, i64 71, i64 72, i64 73, i64 74, i64 75, i64 76, i64 77, i64 78, i64 79>
  %114 = add nuw <16 x i64> %94, <i64 80, i64 81, i64 82, i64 83, i64 84, i64 85, i64 86, i64 87, i64 88, i64 89, i64 90, i64 91, i64 92, i64 93, i64 94, i64 95>
  %115 = add nuw <16 x i64> %94, <i64 96, i64 97, i64 98, i64 99, i64 100, i64 101, i64 102, i64 103, i64 104, i64 105, i64 106, i64 107, i64 108, i64 109, i64 110, i64 111>
  %116 = add nuw <16 x i64> %94, <i64 112, i64 113, i64 114, i64 115, i64 116, i64 117, i64 118, i64 119, i64 120, i64 121, i64 122, i64 123, i64 124, i64 125, i64 126, i64 127>
  %117 = sub nuw nsw <16 x i64> %113, %97
  %118 = sub nuw nsw <16 x i64> %114, %97
  %119 = sub nuw nsw <16 x i64> %115, %97
  %120 = sub nuw nsw <16 x i64> %116, %97
  %121 = trunc <16 x i64> %117 to <16 x i32>
  %122 = trunc <16 x i64> %118 to <16 x i32>
  %123 = trunc <16 x i64> %119 to <16 x i32>
  %124 = trunc <16 x i64> %120 to <16 x i32>
  %125 = getelementptr [4 x i8], ptr %8, i64 %92
  %126 = getelementptr i8, ptr %125, i64 256
  %127 = getelementptr i8, ptr %125, i64 320
  %128 = getelementptr i8, ptr %125, i64 384
  %129 = getelementptr i8, ptr %125, i64 448
  store <16 x i32> %121, ptr %126, align 4, !tbaa !20
  store <16 x i32> %122, ptr %127, align 4, !tbaa !20
  store <16 x i32> %123, ptr %128, align 4, !tbaa !20
  store <16 x i32> %124, ptr %129, align 4, !tbaa !20
  %130 = add nuw <16 x i64> %94, <i64 128, i64 129, i64 130, i64 131, i64 132, i64 133, i64 134, i64 135, i64 136, i64 137, i64 138, i64 139, i64 140, i64 141, i64 142, i64 143>
  %131 = add nuw <16 x i64> %94, <i64 144, i64 145, i64 146, i64 147, i64 148, i64 149, i64 150, i64 151, i64 152, i64 153, i64 154, i64 155, i64 156, i64 157, i64 158, i64 159>
  %132 = add nuw <16 x i64> %94, <i64 160, i64 161, i64 162, i64 163, i64 164, i64 165, i64 166, i64 167, i64 168, i64 169, i64 170, i64 171, i64 172, i64 173, i64 174, i64 175>
  %133 = add nuw <16 x i64> %94, <i64 176, i64 177, i64 178, i64 179, i64 180, i64 181, i64 182, i64 183, i64 184, i64 185, i64 186, i64 187, i64 188, i64 189, i64 190, i64 191>
  %134 = sub nuw nsw <16 x i64> %130, %97
  %135 = sub nuw nsw <16 x i64> %131, %97
  %136 = sub nuw nsw <16 x i64> %132, %97
  %137 = sub nuw nsw <16 x i64> %133, %97
  %138 = trunc <16 x i64> %134 to <16 x i32>
  %139 = trunc <16 x i64> %135 to <16 x i32>
  %140 = trunc <16 x i64> %136 to <16 x i32>
  %141 = trunc <16 x i64> %137 to <16 x i32>
  %142 = getelementptr [4 x i8], ptr %8, i64 %92
  %143 = getelementptr i8, ptr %142, i64 512
  %144 = getelementptr i8, ptr %142, i64 576
  %145 = getelementptr i8, ptr %142, i64 640
  %146 = getelementptr i8, ptr %142, i64 704
  store <16 x i32> %138, ptr %143, align 4, !tbaa !20
  store <16 x i32> %139, ptr %144, align 4, !tbaa !20
  store <16 x i32> %140, ptr %145, align 4, !tbaa !20
  store <16 x i32> %141, ptr %146, align 4, !tbaa !20
  %147 = add nuw <16 x i64> %94, <i64 192, i64 193, i64 194, i64 195, i64 196, i64 197, i64 198, i64 199, i64 200, i64 201, i64 202, i64 203, i64 204, i64 205, i64 206, i64 207>
  %148 = add nuw <16 x i64> %94, <i64 208, i64 209, i64 210, i64 211, i64 212, i64 213, i64 214, i64 215, i64 216, i64 217, i64 218, i64 219, i64 220, i64 221, i64 222, i64 223>
  %149 = add nuw <16 x i64> %94, <i64 224, i64 225, i64 226, i64 227, i64 228, i64 229, i64 230, i64 231, i64 232, i64 233, i64 234, i64 235, i64 236, i64 237, i64 238, i64 239>
  %150 = add nuw <16 x i64> %94, <i64 240, i64 241, i64 242, i64 243, i64 244, i64 245, i64 246, i64 247, i64 248, i64 249, i64 250, i64 251, i64 252, i64 253, i64 254, i64 255>
  %151 = sub nuw nsw <16 x i64> %147, %97
  %152 = sub nuw nsw <16 x i64> %148, %97
  %153 = sub nuw nsw <16 x i64> %149, %97
  %154 = sub nuw nsw <16 x i64> %150, %97
  %155 = trunc <16 x i64> %151 to <16 x i32>
  %156 = trunc <16 x i64> %152 to <16 x i32>
  %157 = trunc <16 x i64> %153 to <16 x i32>
  %158 = trunc <16 x i64> %154 to <16 x i32>
  %159 = getelementptr [4 x i8], ptr %8, i64 %92
  %160 = getelementptr i8, ptr %159, i64 768
  %161 = getelementptr i8, ptr %159, i64 832
  %162 = getelementptr i8, ptr %159, i64 896
  %163 = getelementptr i8, ptr %159, i64 960
  store <16 x i32> %155, ptr %160, align 4, !tbaa !20
  store <16 x i32> %156, ptr %161, align 4, !tbaa !20
  store <16 x i32> %157, ptr %162, align 4, !tbaa !20
  store <16 x i32> %158, ptr %163, align 4, !tbaa !20
  %164 = and i64 %1, 511
  %165 = getelementptr inbounds nuw i8, ptr %5, i64 1050672
  %166 = and i64 %1, -512
  %167 = getelementptr inbounds nuw [8 x i8], ptr %0, i64 %166
  %168 = shl nuw nsw i64 %164, 3
  tail call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 4 %165, ptr align 4 %167, i64 %168, i1 false)
  %169 = trunc i64 %23 to i32
  %170 = add i32 %169, -1
  %171 = getelementptr inbounds nuw i8, ptr %5, i64 48
  store i32 %170, ptr %171, align 8, !tbaa !27
  %172 = trunc nuw nsw i64 %164 to i32
  %173 = getelementptr inbounds nuw i8, ptr %5, i64 52
  store i32 %172, ptr %173, align 4, !tbaa !29
  tail call fastcc void @sort_step(ptr noundef %5, i32 noundef 0)
  tail call fastcc void @sort_step(ptr noundef %5, i32 noundef 8)
  tail call fastcc void @sort_step(ptr noundef %5, i32 noundef 16)
  tail call fastcc void @sort_step(ptr noundef %5, i32 noundef 24)
  %174 = load ptr, ptr %20, align 8, !tbaa !16
  %175 = load ptr, ptr %21, align 8, !tbaa !17
  %176 = load i64, ptr %19, align 8, !tbaa !15
  %177 = lshr i64 %176, 9
  %178 = and i64 %177, 7
  %179 = add nuw nsw i64 %177, 512
  %180 = and i64 %179, 72057594037927928
  br label %189

181:                                              ; preds = %89, %181
  %182 = phi i64 [ %186, %181 ], [ %90, %89 ]
  %183 = trunc i64 %182 to i32
  %184 = add i32 %183, 256
  %185 = getelementptr inbounds nuw [4 x i8], ptr %8, i64 %182
  store i32 %184, ptr %185, align 4, !tbaa !20
  %186 = add nuw nsw i64 %182, 1
  %187 = icmp eq i64 %186, %40
  br i1 %187, label %91, label %181, !llvm.loop !30

188:                                              ; preds = %4
  tail call void @free(ptr noundef %5) #12
  tail call void @free(ptr noundef %8) #12
  tail call void @free(ptr noundef %9) #12
  tail call void @free(ptr noundef %10) #12
  tail call void @perror(ptr noundef nonnull @.str) #13
  tail call void @abort() #14
  unreachable

189:                                              ; preds = %189, %91
  %190 = phi i64 [ 0, %91 ], [ %239, %189 ]
  %191 = phi i64 [ 0, %91 ], [ %240, %189 ]
  %192 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %190
  %193 = load i32, ptr %192, align 4, !tbaa !20
  %194 = zext i32 %193 to i64
  %195 = trunc i64 %190 to i32
  %196 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %194
  store i32 %195, ptr %196, align 4, !tbaa !20
  %197 = or disjoint i64 %190, 1
  %198 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %197
  %199 = load i32, ptr %198, align 4, !tbaa !20
  %200 = zext i32 %199 to i64
  %201 = trunc i64 %197 to i32
  %202 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %200
  store i32 %201, ptr %202, align 4, !tbaa !20
  %203 = or disjoint i64 %190, 2
  %204 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %203
  %205 = load i32, ptr %204, align 4, !tbaa !20
  %206 = zext i32 %205 to i64
  %207 = trunc i64 %203 to i32
  %208 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %206
  store i32 %207, ptr %208, align 4, !tbaa !20
  %209 = or disjoint i64 %190, 3
  %210 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %209
  %211 = load i32, ptr %210, align 4, !tbaa !20
  %212 = zext i32 %211 to i64
  %213 = trunc i64 %209 to i32
  %214 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %212
  store i32 %213, ptr %214, align 4, !tbaa !20
  %215 = or disjoint i64 %190, 4
  %216 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %215
  %217 = load i32, ptr %216, align 4, !tbaa !20
  %218 = zext i32 %217 to i64
  %219 = trunc i64 %215 to i32
  %220 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %218
  store i32 %219, ptr %220, align 4, !tbaa !20
  %221 = or disjoint i64 %190, 5
  %222 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %221
  %223 = load i32, ptr %222, align 4, !tbaa !20
  %224 = zext i32 %223 to i64
  %225 = trunc i64 %221 to i32
  %226 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %224
  store i32 %225, ptr %226, align 4, !tbaa !20
  %227 = or disjoint i64 %190, 6
  %228 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %227
  %229 = load i32, ptr %228, align 4, !tbaa !20
  %230 = zext i32 %229 to i64
  %231 = trunc i64 %227 to i32
  %232 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %230
  store i32 %231, ptr %232, align 4, !tbaa !20
  %233 = or disjoint i64 %190, 7
  %234 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %233
  %235 = load i32, ptr %234, align 4, !tbaa !20
  %236 = zext i32 %235 to i64
  %237 = trunc i64 %233 to i32
  %238 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %236
  store i32 %237, ptr %238, align 4, !tbaa !20
  %239 = add nuw nsw i64 %190, 8
  %240 = add nuw nsw i64 %191, 8
  %241 = icmp eq i64 %240, %180
  br i1 %241, label %242, label %189, !llvm.loop !31

242:                                              ; preds = %189
  %243 = icmp eq i64 %178, 0
  br i1 %243, label %257, label %244

244:                                              ; preds = %242
  %245 = icmp ne i64 %178, 0
  tail call void @llvm.assume(i1 %245)
  br label %246

246:                                              ; preds = %246, %244
  %247 = phi i64 [ %239, %244 ], [ %254, %246 ]
  %248 = phi i64 [ 0, %244 ], [ %255, %246 ]
  %249 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %247
  %250 = load i32, ptr %249, align 4, !tbaa !20
  %251 = zext i32 %250 to i64
  %252 = trunc i64 %247 to i32
  %253 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %251
  store i32 %252, ptr %253, align 4, !tbaa !20
  %254 = add nuw nsw i64 %247, 1
  %255 = add i64 %248, 1
  %256 = icmp eq i64 %255, %178
  br i1 %256, label %257, label %246, !llvm.loop !32

257:                                              ; preds = %246, %242
  %258 = icmp ult i64 %176, 512
  br i1 %258, label %342, label %259

259:                                              ; preds = %257
  %260 = load i32, ptr %174, align 4, !tbaa !20
  %261 = zext i32 %260 to i64
  %262 = getelementptr inbounds nuw i8, ptr %5, i64 2096
  br label %263

263:                                              ; preds = %314, %259
  %264 = phi i64 [ %261, %259 ], [ %334, %314 ]
  %265 = phi i64 [ 512, %259 ], [ %335, %314 ]
  %266 = phi i64 [ 0, %259 ], [ %331, %314 ]
  %267 = phi i64 [ 0, %259 ], [ %333, %314 ]
  %268 = phi i64 [ 0, %259 ], [ %315, %314 ]
  %269 = add nsw i64 %265, -256
  %270 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %265
  %271 = load i32, ptr %270, align 4, !tbaa !20
  %272 = zext i32 %271 to i64
  %273 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %269
  %274 = load i32, ptr %273, align 4, !tbaa !20
  %275 = zext i32 %274 to i64
  %276 = icmp samesign ult i64 %269, %272
  br i1 %276, label %277, label %302

277:                                              ; preds = %263
  %278 = load i64, ptr %24, align 8, !tbaa !19
  %279 = icmp ugt i64 %278, %272
  br i1 %279, label %280, label %302

280:                                              ; preds = %277
  %281 = icmp samesign ult i64 %264, 512
  br i1 %281, label %282, label %285

282:                                              ; preds = %280
  %283 = getelementptr inbounds nuw [4096 x i8], ptr %262, i64 %264
  %284 = load ptr, ptr %5, align 8, !tbaa !9
  br label %290

285:                                              ; preds = %280
  %286 = load ptr, ptr %5, align 8, !tbaa !9
  %287 = shl nuw nsw i64 %264, 12
  %288 = getelementptr i8, ptr %286, i64 %287
  %289 = getelementptr i8, ptr %288, i64 -2097152
  br label %290

290:                                              ; preds = %285, %282
  %291 = phi ptr [ %284, %282 ], [ %286, %285 ]
  %292 = phi ptr [ %283, %282 ], [ %289, %285 ]
  %293 = shl nuw nsw i64 %265, 12
  %294 = getelementptr i8, ptr %291, i64 %293
  %295 = getelementptr i8, ptr %294, i64 -2097152
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 4 dereferenceable(4096) %292, ptr noundef nonnull align 4 dereferenceable(4096) %295, i64 4096, i1 false)
  %296 = trunc i64 %265 to i32
  %297 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %267
  store i32 %296, ptr %297, align 4, !tbaa !20
  %298 = trunc nuw i64 %264 to i32
  %299 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %272
  store i32 %298, ptr %299, align 4, !tbaa !20
  %300 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %264
  store i32 %271, ptr %300, align 4, !tbaa !20
  %301 = trunc nuw i64 %267 to i32
  store i32 %301, ptr %270, align 4, !tbaa !20
  br label %302

302:                                              ; preds = %290, %277, %263
  %303 = phi i64 [ %267, %290 ], [ %272, %277 ], [ %272, %263 ]
  %304 = phi i64 [ %272, %290 ], [ %267, %277 ], [ %267, %263 ]
  %305 = getelementptr inbounds nuw [8 x i8], ptr %171, i64 %268
  %306 = load i32, ptr %305, align 8, !tbaa !27
  %307 = zext i32 %306 to i64
  %308 = icmp eq i64 %269, %307
  br i1 %308, label %309, label %314

309:                                              ; preds = %302
  %310 = getelementptr inbounds nuw i8, ptr %305, i64 4
  %311 = load i32, ptr %310, align 4, !tbaa !29
  %312 = zext i32 %311 to i64
  %313 = add i64 %268, 1
  br label %314

314:                                              ; preds = %309, %302
  %315 = phi i64 [ %313, %309 ], [ %268, %302 ]
  %316 = phi i64 [ %312, %309 ], [ 512, %302 ]
  %317 = load ptr, ptr %5, align 8, !tbaa !9
  %318 = getelementptr inbounds nuw [8 x i8], ptr %317, i64 %266
  %319 = icmp ult i32 %274, 512
  %320 = getelementptr inbounds nuw [4096 x i8], ptr %262, i64 %275
  %321 = shl nuw nsw i64 %275, 12
  %322 = getelementptr i8, ptr %317, i64 %321
  %323 = getelementptr i8, ptr %322, i64 -2097152
  %324 = select i1 %319, ptr %320, ptr %323
  %325 = shl nuw nsw i64 %316, 3
  tail call void @llvm.memmove.p0.p0.i64(ptr align 4 %318, ptr align 4 %324, i64 %325, i1 false)
  %326 = trunc i64 %265 to i32
  store i32 %326, ptr %273, align 4, !tbaa !20
  %327 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %303
  store i32 %274, ptr %327, align 4, !tbaa !20
  %328 = trunc nuw i64 %303 to i32
  %329 = getelementptr inbounds nuw [4 x i8], ptr %175, i64 %275
  store i32 %328, ptr %329, align 4, !tbaa !20
  %330 = trunc i64 %269 to i32
  store i32 %330, ptr %270, align 4, !tbaa !20
  %331 = add i64 %316, %266
  %332 = icmp eq i64 %269, %303
  %333 = select i1 %332, i64 %304, i64 %303
  %334 = select i1 %332, i64 %264, i64 %275
  %335 = add nuw nsw i64 %265, 1
  %336 = load i64, ptr %19, align 8, !tbaa !15
  %337 = lshr i64 %336, 9
  %338 = add nuw nsw i64 %337, 512
  %339 = icmp samesign ult i64 %335, %338
  br i1 %339, label %263, label %340, !llvm.loop !34

340:                                              ; preds = %314
  %341 = add nsw i64 %265, -255
  br label %342

342:                                              ; preds = %340, %257
  %343 = phi i64 [ 0, %257 ], [ %315, %340 ]
  %344 = phi i64 [ 0, %257 ], [ %331, %340 ]
  %345 = phi i64 [ 256, %257 ], [ %341, %340 ]
  %346 = load i64, ptr %24, align 8, !tbaa !19
  %347 = icmp ult i64 %345, %346
  br i1 %347, label %348, label %382

348:                                              ; preds = %342
  %349 = getelementptr inbounds nuw i8, ptr %5, i64 2096
  br label %350

350:                                              ; preds = %366, %348
  %351 = phi i64 [ %344, %348 ], [ %378, %366 ]
  %352 = phi i64 [ %345, %348 ], [ %379, %366 ]
  %353 = phi i64 [ %343, %348 ], [ %367, %366 ]
  %354 = getelementptr inbounds nuw [4 x i8], ptr %174, i64 %352
  %355 = load i32, ptr %354, align 4, !tbaa !20
  %356 = zext i32 %355 to i64
  %357 = getelementptr inbounds nuw [8 x i8], ptr %171, i64 %353
  %358 = load i32, ptr %357, align 8, !tbaa !27
  %359 = zext i32 %358 to i64
  %360 = icmp eq i64 %352, %359
  br i1 %360, label %361, label %366

361:                                              ; preds = %350
  %362 = getelementptr inbounds nuw i8, ptr %357, i64 4
  %363 = load i32, ptr %362, align 4, !tbaa !29
  %364 = zext i32 %363 to i64
  %365 = add i64 %353, 1
  br label %366

366:                                              ; preds = %361, %350
  %367 = phi i64 [ %365, %361 ], [ %353, %350 ]
  %368 = phi i64 [ %364, %361 ], [ 512, %350 ]
  %369 = load ptr, ptr %5, align 8, !tbaa !9
  %370 = getelementptr inbounds nuw [8 x i8], ptr %369, i64 %351
  %371 = icmp ult i32 %355, 512
  %372 = getelementptr inbounds nuw [4096 x i8], ptr %349, i64 %356
  %373 = shl nuw nsw i64 %356, 12
  %374 = getelementptr i8, ptr %369, i64 %373
  %375 = getelementptr i8, ptr %374, i64 -2097152
  %376 = select i1 %371, ptr %372, ptr %375
  %377 = shl nuw nsw i64 %368, 3
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 4 %370, ptr align 4 %376, i64 %377, i1 false)
  %378 = add i64 %368, %351
  %379 = add nuw i64 %352, 1
  %380 = load i64, ptr %24, align 8, !tbaa !19
  %381 = icmp ult i64 %379, %380
  br i1 %381, label %350, label %382, !llvm.loop !35

382:                                              ; preds = %366, %342
  %383 = load ptr, ptr %20, align 8, !tbaa !16
  tail call void @free(ptr noundef %383) #12
  %384 = load ptr, ptr %21, align 8, !tbaa !17
  tail call void @free(ptr noundef %384) #12
  %385 = load ptr, ptr %22, align 8, !tbaa !18
  tail call void @free(ptr noundef %385) #12
  tail call void @free(ptr noundef nonnull %5) #12
  br label %386

386:                                              ; preds = %2, %382
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: cold nofree nounwind
declare void @perror(ptr noundef readonly captures(none)) local_unnamed_addr #2

; Function Attrs: cold nofree noreturn nounwind
declare void @abort() local_unnamed_addr #3

; Function Attrs: nofree norecurse nosync nounwind sspstrong memory(readwrite, inaccessiblemem: none, target_mem: none) uwtable
define internal fastcc void @sort_step(ptr noundef nonnull %0, i32 noundef range(i32 0, 25) %1) unnamed_addr #4 {
  %3 = alloca [256 x i32], align 16
  %4 = alloca [256 x %struct.bucket], align 16
  %5 = alloca [256 x i32], align 16
  call void @llvm.lifetime.start.p0(ptr nonnull %4) #12
  call void @llvm.lifetime.start.p0(ptr nonnull %5) #12
  %6 = getelementptr inbounds nuw i8, ptr %0, i64 24
  %7 = getelementptr inbounds nuw i8, ptr %0, i64 40
  %8 = getelementptr inbounds nuw i8, ptr %0, i64 2096
  br label %15

9:                                                ; preds = %95
  %10 = getelementptr inbounds nuw i8, ptr %0, i64 16
  %11 = load i64, ptr %10, align 8, !tbaa !19
  %12 = icmp ugt i64 %11, 256
  br i1 %12, label %13, label %274

13:                                               ; preds = %9
  %14 = getelementptr inbounds nuw i8, ptr %0, i64 48
  br label %106

15:                                               ; preds = %95, %2
  %16 = phi i64 [ 0, %2 ], [ %104, %95 ]
  %17 = load ptr, ptr %6, align 8, !tbaa !16
  %18 = getelementptr inbounds nuw [4 x i8], ptr %17, i64 %16
  %19 = load i32, ptr %18, align 4, !tbaa !20
  %20 = zext i32 %19 to i64
  %21 = icmp ult i32 %19, 512
  br i1 %21, label %22, label %24

22:                                               ; preds = %15
  %23 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %20
  br label %29

24:                                               ; preds = %15
  %25 = load ptr, ptr %0, align 8, !tbaa !9
  %26 = shl nuw nsw i64 %20, 12
  %27 = getelementptr i8, ptr %25, i64 %26
  %28 = getelementptr i8, ptr %27, i64 -2097152
  br label %29

29:                                               ; preds = %22, %24
  %30 = phi ptr [ %23, %22 ], [ %28, %24 ]
  %31 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %16
  store ptr %30, ptr %31, align 16, !tbaa !36
  %32 = getelementptr inbounds nuw i8, ptr %30, i64 4096
  %33 = getelementptr inbounds nuw i8, ptr %31, i64 8
  store ptr %32, ptr %33, align 8, !tbaa !38
  %34 = trunc nuw i64 %16 to i8
  %35 = load ptr, ptr %7, align 8, !tbaa !18
  %36 = getelementptr inbounds nuw i8, ptr %35, i64 %16
  store i8 %34, ptr %36, align 1, !tbaa !39
  %37 = getelementptr inbounds nuw [4 x i8], ptr %5, i64 %16
  store i32 1, ptr %37, align 16, !tbaa !20
  %38 = or disjoint i64 %16, 1
  %39 = load ptr, ptr %6, align 8, !tbaa !16
  %40 = getelementptr inbounds nuw [4 x i8], ptr %39, i64 %38
  %41 = load i32, ptr %40, align 4, !tbaa !20
  %42 = zext i32 %41 to i64
  %43 = icmp ult i32 %41, 512
  br i1 %43, label %49, label %44

44:                                               ; preds = %29
  %45 = load ptr, ptr %0, align 8, !tbaa !9
  %46 = shl nuw nsw i64 %42, 12
  %47 = getelementptr i8, ptr %45, i64 %46
  %48 = getelementptr i8, ptr %47, i64 -2097152
  br label %51

49:                                               ; preds = %29
  %50 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %42
  br label %51

51:                                               ; preds = %49, %44
  %52 = phi ptr [ %50, %49 ], [ %48, %44 ]
  %53 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %38
  store ptr %52, ptr %53, align 16, !tbaa !36
  %54 = getelementptr inbounds nuw i8, ptr %52, i64 4096
  %55 = getelementptr inbounds nuw i8, ptr %53, i64 8
  store ptr %54, ptr %55, align 8, !tbaa !38
  %56 = trunc nuw i64 %38 to i8
  %57 = load ptr, ptr %7, align 8, !tbaa !18
  %58 = getelementptr inbounds nuw i8, ptr %57, i64 %38
  store i8 %56, ptr %58, align 1, !tbaa !39
  %59 = getelementptr inbounds nuw [4 x i8], ptr %5, i64 %38
  store i32 1, ptr %59, align 4, !tbaa !20
  %60 = or disjoint i64 %16, 2
  %61 = load ptr, ptr %6, align 8, !tbaa !16
  %62 = getelementptr inbounds nuw [4 x i8], ptr %61, i64 %60
  %63 = load i32, ptr %62, align 4, !tbaa !20
  %64 = zext i32 %63 to i64
  %65 = icmp ult i32 %63, 512
  br i1 %65, label %71, label %66

66:                                               ; preds = %51
  %67 = load ptr, ptr %0, align 8, !tbaa !9
  %68 = shl nuw nsw i64 %64, 12
  %69 = getelementptr i8, ptr %67, i64 %68
  %70 = getelementptr i8, ptr %69, i64 -2097152
  br label %73

71:                                               ; preds = %51
  %72 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %64
  br label %73

73:                                               ; preds = %71, %66
  %74 = phi ptr [ %72, %71 ], [ %70, %66 ]
  %75 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %60
  store ptr %74, ptr %75, align 16, !tbaa !36
  %76 = getelementptr inbounds nuw i8, ptr %74, i64 4096
  %77 = getelementptr inbounds nuw i8, ptr %75, i64 8
  store ptr %76, ptr %77, align 8, !tbaa !38
  %78 = trunc nuw i64 %60 to i8
  %79 = load ptr, ptr %7, align 8, !tbaa !18
  %80 = getelementptr inbounds nuw i8, ptr %79, i64 %60
  store i8 %78, ptr %80, align 1, !tbaa !39
  %81 = getelementptr inbounds nuw [4 x i8], ptr %5, i64 %60
  store i32 1, ptr %81, align 8, !tbaa !20
  %82 = or disjoint i64 %16, 3
  %83 = load ptr, ptr %6, align 8, !tbaa !16
  %84 = getelementptr inbounds nuw [4 x i8], ptr %83, i64 %82
  %85 = load i32, ptr %84, align 4, !tbaa !20
  %86 = zext i32 %85 to i64
  %87 = icmp ult i32 %85, 512
  br i1 %87, label %93, label %88

88:                                               ; preds = %73
  %89 = load ptr, ptr %0, align 8, !tbaa !9
  %90 = shl nuw nsw i64 %86, 12
  %91 = getelementptr i8, ptr %89, i64 %90
  %92 = getelementptr i8, ptr %91, i64 -2097152
  br label %95

93:                                               ; preds = %73
  %94 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %86
  br label %95

95:                                               ; preds = %93, %88
  %96 = phi ptr [ %94, %93 ], [ %92, %88 ]
  %97 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %82
  store ptr %96, ptr %97, align 16, !tbaa !36
  %98 = getelementptr inbounds nuw i8, ptr %96, i64 4096
  %99 = getelementptr inbounds nuw i8, ptr %97, i64 8
  store ptr %98, ptr %99, align 8, !tbaa !38
  %100 = trunc nuw i64 %82 to i8
  %101 = load ptr, ptr %7, align 8, !tbaa !18
  %102 = getelementptr inbounds nuw i8, ptr %101, i64 %82
  store i8 %100, ptr %102, align 1, !tbaa !39
  %103 = getelementptr inbounds nuw [4 x i8], ptr %5, i64 %82
  store i32 1, ptr %103, align 4, !tbaa !20
  %104 = add nuw nsw i64 %16, 4
  %105 = icmp eq i64 %104, 256
  br i1 %105, label %9, label %15, !llvm.loop !40

106:                                              ; preds = %13, %268
  %107 = phi i64 [ %11, %13 ], [ %270, %268 ]
  %108 = phi i64 [ 256, %13 ], [ %272, %268 ]
  %109 = phi i64 [ 256, %13 ], [ %271, %268 ]
  %110 = phi i64 [ 0, %13 ], [ %269, %268 ]
  %111 = load ptr, ptr %6, align 8, !tbaa !16
  %112 = getelementptr inbounds nuw [4 x i8], ptr %111, i64 %108
  %113 = load i32, ptr %112, align 4, !tbaa !20
  %114 = zext i32 %113 to i64
  %115 = icmp ult i32 %113, 512
  br i1 %115, label %116, label %118

116:                                              ; preds = %106
  %117 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %114
  br label %123

118:                                              ; preds = %106
  %119 = load ptr, ptr %0, align 8, !tbaa !9
  %120 = shl nuw nsw i64 %114, 12
  %121 = getelementptr i8, ptr %119, i64 %120
  %122 = getelementptr i8, ptr %121, i64 -2097152
  br label %123

123:                                              ; preds = %116, %118
  %124 = phi ptr [ %117, %116 ], [ %122, %118 ]
  %125 = getelementptr inbounds nuw [8 x i8], ptr %14, i64 %110
  %126 = load i32, ptr %125, align 8, !tbaa !27
  %127 = zext i32 %126 to i64
  %128 = icmp eq i64 %108, %127
  br i1 %128, label %129, label %135

129:                                              ; preds = %123
  %130 = getelementptr inbounds nuw i8, ptr %125, i64 4
  %131 = load i32, ptr %130, align 4, !tbaa !29
  %132 = zext i32 %131 to i64
  %133 = add i64 %110, 1
  %134 = icmp eq i32 %131, 0
  br i1 %134, label %268, label %135

135:                                              ; preds = %123, %129
  %136 = phi i64 [ %132, %129 ], [ 512, %123 ]
  %137 = phi i64 [ %133, %129 ], [ %110, %123 ]
  %138 = and i64 %136, 1
  %139 = icmp eq i64 %136, 1
  br i1 %139, label %226, label %140

140:                                              ; preds = %135
  %141 = and i64 %136, 4294967294
  br label %142

142:                                              ; preds = %219, %140
  %143 = phi i64 [ %109, %140 ], [ %220, %219 ]
  %144 = phi i64 [ 0, %140 ], [ %221, %219 ]
  %145 = phi i64 [ 0, %140 ], [ %222, %219 ]
  %146 = getelementptr inbounds nuw [8 x i8], ptr %124, i64 %144
  %147 = load i32, ptr %146, align 4, !tbaa !20
  %148 = lshr i32 %147, %1
  %149 = and i32 %148, 255
  %150 = zext nneg i32 %149 to i64
  %151 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %150
  %152 = load ptr, ptr %151, align 16, !tbaa !36
  %153 = getelementptr inbounds nuw i8, ptr %152, i64 8
  %154 = load i64, ptr %146, align 4
  store i64 %154, ptr %152, align 4
  store ptr %153, ptr %151, align 16, !tbaa !36
  %155 = getelementptr inbounds nuw i8, ptr %151, i64 8
  %156 = load ptr, ptr %155, align 8, !tbaa !38
  %157 = icmp eq ptr %153, %156
  br i1 %157, label %158, label %181

158:                                              ; preds = %142
  %159 = load ptr, ptr %6, align 8, !tbaa !16
  %160 = getelementptr inbounds nuw [4 x i8], ptr %159, i64 %143
  %161 = load i32, ptr %160, align 4, !tbaa !20
  %162 = zext i32 %161 to i64
  %163 = icmp ult i32 %161, 512
  br i1 %163, label %164, label %166

164:                                              ; preds = %158
  %165 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %162
  br label %171

166:                                              ; preds = %158
  %167 = load ptr, ptr %0, align 8, !tbaa !9
  %168 = shl nuw nsw i64 %162, 12
  %169 = getelementptr i8, ptr %167, i64 %168
  %170 = getelementptr i8, ptr %169, i64 -2097152
  br label %171

171:                                              ; preds = %164, %166
  %172 = phi ptr [ %165, %164 ], [ %170, %166 ]
  store ptr %172, ptr %151, align 16, !tbaa !36
  %173 = getelementptr inbounds nuw i8, ptr %172, i64 4096
  store ptr %173, ptr %155, align 8, !tbaa !38
  %174 = trunc i32 %148 to i8
  %175 = load ptr, ptr %7, align 8, !tbaa !18
  %176 = getelementptr inbounds nuw i8, ptr %175, i64 %143
  store i8 %174, ptr %176, align 1, !tbaa !39
  %177 = getelementptr inbounds nuw [4 x i8], ptr %5, i64 %150
  %178 = load i32, ptr %177, align 4, !tbaa !20
  %179 = add i32 %178, 1
  store i32 %179, ptr %177, align 4, !tbaa !20
  %180 = add i64 %143, 1
  br label %181

181:                                              ; preds = %171, %142
  %182 = phi i64 [ %180, %171 ], [ %143, %142 ]
  %183 = getelementptr inbounds nuw [8 x i8], ptr %124, i64 %144
  %184 = getelementptr inbounds nuw i8, ptr %183, i64 8
  %185 = load i32, ptr %184, align 4, !tbaa !20
  %186 = lshr i32 %185, %1
  %187 = and i32 %186, 255
  %188 = zext nneg i32 %187 to i64
  %189 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %188
  %190 = load ptr, ptr %189, align 16, !tbaa !36
  %191 = getelementptr inbounds nuw i8, ptr %190, i64 8
  %192 = load i64, ptr %184, align 4
  store i64 %192, ptr %190, align 4
  store ptr %191, ptr %189, align 16, !tbaa !36
  %193 = getelementptr inbounds nuw i8, ptr %189, i64 8
  %194 = load ptr, ptr %193, align 8, !tbaa !38
  %195 = icmp eq ptr %191, %194
  br i1 %195, label %196, label %219

196:                                              ; preds = %181
  %197 = load ptr, ptr %6, align 8, !tbaa !16
  %198 = getelementptr inbounds nuw [4 x i8], ptr %197, i64 %182
  %199 = load i32, ptr %198, align 4, !tbaa !20
  %200 = zext i32 %199 to i64
  %201 = icmp ult i32 %199, 512
  br i1 %201, label %207, label %202

202:                                              ; preds = %196
  %203 = load ptr, ptr %0, align 8, !tbaa !9
  %204 = shl nuw nsw i64 %200, 12
  %205 = getelementptr i8, ptr %203, i64 %204
  %206 = getelementptr i8, ptr %205, i64 -2097152
  br label %209

207:                                              ; preds = %196
  %208 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %200
  br label %209

209:                                              ; preds = %207, %202
  %210 = phi ptr [ %208, %207 ], [ %206, %202 ]
  store ptr %210, ptr %189, align 16, !tbaa !36
  %211 = getelementptr inbounds nuw i8, ptr %210, i64 4096
  store ptr %211, ptr %193, align 8, !tbaa !38
  %212 = trunc i32 %186 to i8
  %213 = load ptr, ptr %7, align 8, !tbaa !18
  %214 = getelementptr inbounds nuw i8, ptr %213, i64 %182
  store i8 %212, ptr %214, align 1, !tbaa !39
  %215 = getelementptr inbounds nuw [4 x i8], ptr %5, i64 %188
  %216 = load i32, ptr %215, align 4, !tbaa !20
  %217 = add i32 %216, 1
  store i32 %217, ptr %215, align 4, !tbaa !20
  %218 = add i64 %182, 1
  br label %219

219:                                              ; preds = %209, %181
  %220 = phi i64 [ %218, %209 ], [ %182, %181 ]
  %221 = add nuw nsw i64 %144, 2
  %222 = add i64 %145, 2
  %223 = icmp eq i64 %222, %141
  br i1 %223, label %224, label %142, !llvm.loop !41

224:                                              ; preds = %219
  %225 = icmp eq i64 %138, 0
  br i1 %225, label %265, label %226

226:                                              ; preds = %224, %135
  %227 = phi i64 [ %109, %135 ], [ %220, %224 ]
  %228 = phi i64 [ 0, %135 ], [ %221, %224 ]
  %229 = trunc i64 %136 to i1
  tail call void @llvm.assume(i1 %229)
  %230 = getelementptr inbounds nuw [8 x i8], ptr %124, i64 %228
  %231 = load i32, ptr %230, align 4, !tbaa !20
  %232 = lshr i32 %231, %1
  %233 = and i32 %232, 255
  %234 = zext nneg i32 %233 to i64
  %235 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %234
  %236 = load ptr, ptr %235, align 16, !tbaa !36
  %237 = getelementptr inbounds nuw i8, ptr %236, i64 8
  %238 = load i64, ptr %230, align 4
  store i64 %238, ptr %236, align 4
  store ptr %237, ptr %235, align 16, !tbaa !36
  %239 = getelementptr inbounds nuw i8, ptr %235, i64 8
  %240 = load ptr, ptr %239, align 8, !tbaa !38
  %241 = icmp eq ptr %237, %240
  br i1 %241, label %242, label %265

242:                                              ; preds = %226
  %243 = load ptr, ptr %6, align 8, !tbaa !16
  %244 = getelementptr inbounds nuw [4 x i8], ptr %243, i64 %227
  %245 = load i32, ptr %244, align 4, !tbaa !20
  %246 = zext i32 %245 to i64
  %247 = icmp ult i32 %245, 512
  br i1 %247, label %253, label %248

248:                                              ; preds = %242
  %249 = load ptr, ptr %0, align 8, !tbaa !9
  %250 = shl nuw nsw i64 %246, 12
  %251 = getelementptr i8, ptr %249, i64 %250
  %252 = getelementptr i8, ptr %251, i64 -2097152
  br label %255

253:                                              ; preds = %242
  %254 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %246
  br label %255

255:                                              ; preds = %253, %248
  %256 = phi ptr [ %254, %253 ], [ %252, %248 ]
  store ptr %256, ptr %235, align 16, !tbaa !36
  %257 = getelementptr inbounds nuw i8, ptr %256, i64 4096
  store ptr %257, ptr %239, align 8, !tbaa !38
  %258 = trunc i32 %232 to i8
  %259 = load ptr, ptr %7, align 8, !tbaa !18
  %260 = getelementptr inbounds nuw i8, ptr %259, i64 %227
  store i8 %258, ptr %260, align 1, !tbaa !39
  %261 = getelementptr inbounds nuw [4 x i8], ptr %5, i64 %234
  %262 = load i32, ptr %261, align 4, !tbaa !20
  %263 = add i32 %262, 1
  store i32 %263, ptr %261, align 4, !tbaa !20
  %264 = add i64 %227, 1
  br label %265

265:                                              ; preds = %226, %255, %224
  %266 = phi i64 [ %220, %224 ], [ %264, %255 ], [ %227, %226 ]
  %267 = load i64, ptr %10, align 8, !tbaa !19
  br label %268

268:                                              ; preds = %265, %129
  %269 = phi i64 [ %133, %129 ], [ %137, %265 ]
  %270 = phi i64 [ %107, %129 ], [ %267, %265 ]
  %271 = phi i64 [ %109, %129 ], [ %266, %265 ]
  %272 = add nuw i64 %108, 1
  %273 = icmp ult i64 %272, %270
  br i1 %273, label %106, label %274, !llvm.loop !42

274:                                              ; preds = %268, %9
  %275 = phi i64 [ 256, %9 ], [ %271, %268 ]
  store i64 %275, ptr %10, align 8, !tbaa !19
  call void @llvm.lifetime.start.p0(ptr nonnull %3) #12
  store i32 256, ptr %3, align 16, !tbaa !20
  br label %276

276:                                              ; preds = %276, %274
  %277 = phi i32 [ 256, %274 ], [ %378, %276 ]
  %278 = phi i64 [ 1, %274 ], [ %380, %276 ]
  %279 = getelementptr [4 x i8], ptr %5, i64 %278
  %280 = getelementptr i8, ptr %279, i64 -4
  %281 = load i32, ptr %280, align 4, !tbaa !20
  %282 = add i32 %281, %277
  %283 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %278
  store i32 %282, ptr %283, align 4, !tbaa !20
  %284 = add nuw nsw i64 %278, 1
  %285 = getelementptr [4 x i8], ptr %5, i64 %284
  %286 = getelementptr i8, ptr %285, i64 -4
  %287 = load i32, ptr %286, align 4, !tbaa !20
  %288 = add i32 %287, %282
  %289 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %284
  store i32 %288, ptr %289, align 4, !tbaa !20
  %290 = add nuw nsw i64 %278, 2
  %291 = getelementptr [4 x i8], ptr %5, i64 %290
  %292 = getelementptr i8, ptr %291, i64 -4
  %293 = load i32, ptr %292, align 4, !tbaa !20
  %294 = add i32 %293, %288
  %295 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %290
  store i32 %294, ptr %295, align 4, !tbaa !20
  %296 = add nuw nsw i64 %278, 3
  %297 = getelementptr [4 x i8], ptr %5, i64 %296
  %298 = getelementptr i8, ptr %297, i64 -4
  %299 = load i32, ptr %298, align 4, !tbaa !20
  %300 = add i32 %299, %294
  %301 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %296
  store i32 %300, ptr %301, align 4, !tbaa !20
  %302 = add nuw nsw i64 %278, 4
  %303 = getelementptr [4 x i8], ptr %5, i64 %302
  %304 = getelementptr i8, ptr %303, i64 -4
  %305 = load i32, ptr %304, align 4, !tbaa !20
  %306 = add i32 %305, %300
  %307 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %302
  store i32 %306, ptr %307, align 4, !tbaa !20
  %308 = add nuw nsw i64 %278, 5
  %309 = getelementptr [4 x i8], ptr %5, i64 %308
  %310 = getelementptr i8, ptr %309, i64 -4
  %311 = load i32, ptr %310, align 4, !tbaa !20
  %312 = add i32 %311, %306
  %313 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %308
  store i32 %312, ptr %313, align 4, !tbaa !20
  %314 = add nuw nsw i64 %278, 6
  %315 = getelementptr [4 x i8], ptr %5, i64 %314
  %316 = getelementptr i8, ptr %315, i64 -4
  %317 = load i32, ptr %316, align 4, !tbaa !20
  %318 = add i32 %317, %312
  %319 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %314
  store i32 %318, ptr %319, align 4, !tbaa !20
  %320 = add nuw nsw i64 %278, 7
  %321 = getelementptr [4 x i8], ptr %5, i64 %320
  %322 = getelementptr i8, ptr %321, i64 -4
  %323 = load i32, ptr %322, align 4, !tbaa !20
  %324 = add i32 %323, %318
  %325 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %320
  store i32 %324, ptr %325, align 4, !tbaa !20
  %326 = add nuw nsw i64 %278, 8
  %327 = getelementptr [4 x i8], ptr %5, i64 %326
  %328 = getelementptr i8, ptr %327, i64 -4
  %329 = load i32, ptr %328, align 4, !tbaa !20
  %330 = add i32 %329, %324
  %331 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %326
  store i32 %330, ptr %331, align 4, !tbaa !20
  %332 = add nuw nsw i64 %278, 9
  %333 = getelementptr [4 x i8], ptr %5, i64 %332
  %334 = getelementptr i8, ptr %333, i64 -4
  %335 = load i32, ptr %334, align 4, !tbaa !20
  %336 = add i32 %335, %330
  %337 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %332
  store i32 %336, ptr %337, align 4, !tbaa !20
  %338 = add nuw nsw i64 %278, 10
  %339 = getelementptr [4 x i8], ptr %5, i64 %338
  %340 = getelementptr i8, ptr %339, i64 -4
  %341 = load i32, ptr %340, align 4, !tbaa !20
  %342 = add i32 %341, %336
  %343 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %338
  store i32 %342, ptr %343, align 4, !tbaa !20
  %344 = add nuw nsw i64 %278, 11
  %345 = getelementptr [4 x i8], ptr %5, i64 %344
  %346 = getelementptr i8, ptr %345, i64 -4
  %347 = load i32, ptr %346, align 4, !tbaa !20
  %348 = add i32 %347, %342
  %349 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %344
  store i32 %348, ptr %349, align 4, !tbaa !20
  %350 = add nuw nsw i64 %278, 12
  %351 = getelementptr [4 x i8], ptr %5, i64 %350
  %352 = getelementptr i8, ptr %351, i64 -4
  %353 = load i32, ptr %352, align 4, !tbaa !20
  %354 = add i32 %353, %348
  %355 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %350
  store i32 %354, ptr %355, align 4, !tbaa !20
  %356 = add nuw nsw i64 %278, 13
  %357 = getelementptr [4 x i8], ptr %5, i64 %356
  %358 = getelementptr i8, ptr %357, i64 -4
  %359 = load i32, ptr %358, align 4, !tbaa !20
  %360 = add i32 %359, %354
  %361 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %356
  store i32 %360, ptr %361, align 4, !tbaa !20
  %362 = add nuw nsw i64 %278, 14
  %363 = getelementptr [4 x i8], ptr %5, i64 %362
  %364 = getelementptr i8, ptr %363, i64 -4
  %365 = load i32, ptr %364, align 4, !tbaa !20
  %366 = add i32 %365, %360
  %367 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %362
  store i32 %366, ptr %367, align 4, !tbaa !20
  %368 = add nuw nsw i64 %278, 15
  %369 = getelementptr [4 x i8], ptr %5, i64 %368
  %370 = getelementptr i8, ptr %369, i64 -4
  %371 = load i32, ptr %370, align 4, !tbaa !20
  %372 = add i32 %371, %366
  %373 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %368
  store i32 %372, ptr %373, align 4, !tbaa !20
  %374 = add nuw nsw i64 %278, 16
  %375 = getelementptr [4 x i8], ptr %5, i64 %374
  %376 = getelementptr i8, ptr %375, i64 -4
  %377 = load i32, ptr %376, align 4, !tbaa !20
  %378 = add i32 %377, %372
  %379 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %374
  store i32 %378, ptr %379, align 4, !tbaa !20
  %380 = add nuw nsw i64 %278, 17
  %381 = icmp eq i64 %380, 256
  br i1 %381, label %382, label %276, !llvm.loop !43

382:                                              ; preds = %276
  %383 = getelementptr inbounds nuw i8, ptr %0, i64 32
  %384 = load ptr, ptr %383, align 8, !tbaa !17
  %385 = icmp eq i64 %275, 0
  br i1 %385, label %386, label %388

386:                                              ; preds = %382
  %387 = load ptr, ptr %6, align 8, !tbaa !16
  br label %518

388:                                              ; preds = %382
  %389 = load ptr, ptr %7, align 8, !tbaa !18
  %390 = load ptr, ptr %6, align 8, !tbaa !16
  %391 = getelementptr inbounds nuw i8, ptr %0, i64 48
  %392 = and i64 %275, 1
  %393 = icmp eq i64 %275, 1
  br i1 %393, label %479, label %394

394:                                              ; preds = %388
  %395 = and i64 %275, -2
  br label %396

396:                                              ; preds = %473, %394
  %397 = phi i64 [ 0, %394 ], [ %474, %473 ]
  %398 = phi i64 [ 0, %394 ], [ %475, %473 ]
  %399 = getelementptr inbounds nuw i8, ptr %389, i64 %397
  %400 = load i8, ptr %399, align 1, !tbaa !39
  %401 = zext i8 %400 to i64
  %402 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %401
  %403 = load i32, ptr %402, align 4, !tbaa !20
  %404 = add i32 %403, 1
  store i32 %404, ptr %402, align 4, !tbaa !20
  %405 = zext i32 %403 to i64
  %406 = getelementptr inbounds nuw [4 x i8], ptr %390, i64 %397
  %407 = load i32, ptr %406, align 4, !tbaa !20
  %408 = getelementptr inbounds nuw [4 x i8], ptr %384, i64 %405
  store i32 %407, ptr %408, align 4, !tbaa !20
  %409 = zext i32 %407 to i64
  %410 = icmp ult i32 %407, 512
  br i1 %410, label %411, label %413

411:                                              ; preds = %396
  %412 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %409
  br label %418

413:                                              ; preds = %396
  %414 = load ptr, ptr %0, align 8, !tbaa !9
  %415 = shl nuw nsw i64 %409, 12
  %416 = getelementptr i8, ptr %414, i64 %415
  %417 = getelementptr i8, ptr %416, i64 -2097152
  br label %418

418:                                              ; preds = %413, %411
  %419 = phi ptr [ %412, %411 ], [ %417, %413 ]
  %420 = getelementptr inbounds nuw i8, ptr %419, i64 4096
  %421 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %401
  %422 = getelementptr inbounds nuw i8, ptr %421, i64 8
  %423 = load ptr, ptr %422, align 8, !tbaa !38
  %424 = icmp eq ptr %420, %423
  br i1 %424, label %425, label %435

425:                                              ; preds = %418
  %426 = getelementptr inbounds nuw [8 x i8], ptr %391, i64 %401
  store i32 %403, ptr %426, align 8, !tbaa !27
  %427 = load ptr, ptr %421, align 16, !tbaa !36
  %428 = ptrtoint ptr %420 to i64
  %429 = ptrtoint ptr %427 to i64
  %430 = sub i64 %428, %429
  %431 = lshr exact i64 %430, 3
  %432 = trunc i64 %431 to i32
  %433 = sub i32 512, %432
  %434 = getelementptr inbounds nuw i8, ptr %426, i64 4
  store i32 %433, ptr %434, align 4, !tbaa !29
  br label %435

435:                                              ; preds = %425, %418
  %436 = or disjoint i64 %397, 1
  %437 = getelementptr inbounds nuw i8, ptr %389, i64 %436
  %438 = load i8, ptr %437, align 1, !tbaa !39
  %439 = zext i8 %438 to i64
  %440 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %439
  %441 = load i32, ptr %440, align 4, !tbaa !20
  %442 = add i32 %441, 1
  store i32 %442, ptr %440, align 4, !tbaa !20
  %443 = zext i32 %441 to i64
  %444 = getelementptr inbounds nuw [4 x i8], ptr %390, i64 %436
  %445 = load i32, ptr %444, align 4, !tbaa !20
  %446 = getelementptr inbounds nuw [4 x i8], ptr %384, i64 %443
  store i32 %445, ptr %446, align 4, !tbaa !20
  %447 = zext i32 %445 to i64
  %448 = icmp ult i32 %445, 512
  br i1 %448, label %454, label %449

449:                                              ; preds = %435
  %450 = load ptr, ptr %0, align 8, !tbaa !9
  %451 = shl nuw nsw i64 %447, 12
  %452 = getelementptr i8, ptr %450, i64 %451
  %453 = getelementptr i8, ptr %452, i64 -2097152
  br label %456

454:                                              ; preds = %435
  %455 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %447
  br label %456

456:                                              ; preds = %454, %449
  %457 = phi ptr [ %455, %454 ], [ %453, %449 ]
  %458 = getelementptr inbounds nuw i8, ptr %457, i64 4096
  %459 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %439
  %460 = getelementptr inbounds nuw i8, ptr %459, i64 8
  %461 = load ptr, ptr %460, align 8, !tbaa !38
  %462 = icmp eq ptr %458, %461
  br i1 %462, label %463, label %473

463:                                              ; preds = %456
  %464 = getelementptr inbounds nuw [8 x i8], ptr %391, i64 %439
  store i32 %441, ptr %464, align 8, !tbaa !27
  %465 = load ptr, ptr %459, align 16, !tbaa !36
  %466 = ptrtoint ptr %458 to i64
  %467 = ptrtoint ptr %465 to i64
  %468 = sub i64 %466, %467
  %469 = lshr exact i64 %468, 3
  %470 = trunc i64 %469 to i32
  %471 = sub i32 512, %470
  %472 = getelementptr inbounds nuw i8, ptr %464, i64 4
  store i32 %471, ptr %472, align 4, !tbaa !29
  br label %473

473:                                              ; preds = %463, %456
  %474 = add nuw i64 %397, 2
  %475 = add i64 %398, 2
  %476 = icmp eq i64 %475, %395
  br i1 %476, label %477, label %396, !llvm.loop !44

477:                                              ; preds = %473
  %478 = icmp eq i64 %392, 0
  br i1 %478, label %518, label %479

479:                                              ; preds = %477, %388
  %480 = phi i64 [ 0, %388 ], [ %474, %477 ]
  %481 = trunc i64 %275 to i1
  tail call void @llvm.assume(i1 %481)
  %482 = getelementptr inbounds nuw i8, ptr %389, i64 %480
  %483 = load i8, ptr %482, align 1, !tbaa !39
  %484 = zext i8 %483 to i64
  %485 = getelementptr inbounds nuw [4 x i8], ptr %3, i64 %484
  %486 = load i32, ptr %485, align 4, !tbaa !20
  %487 = add i32 %486, 1
  store i32 %487, ptr %485, align 4, !tbaa !20
  %488 = zext i32 %486 to i64
  %489 = getelementptr inbounds nuw [4 x i8], ptr %390, i64 %480
  %490 = load i32, ptr %489, align 4, !tbaa !20
  %491 = getelementptr inbounds nuw [4 x i8], ptr %384, i64 %488
  store i32 %490, ptr %491, align 4, !tbaa !20
  %492 = zext i32 %490 to i64
  %493 = icmp ult i32 %490, 512
  br i1 %493, label %499, label %494

494:                                              ; preds = %479
  %495 = load ptr, ptr %0, align 8, !tbaa !9
  %496 = shl nuw nsw i64 %492, 12
  %497 = getelementptr i8, ptr %495, i64 %496
  %498 = getelementptr i8, ptr %497, i64 -2097152
  br label %501

499:                                              ; preds = %479
  %500 = getelementptr inbounds nuw [4096 x i8], ptr %8, i64 %492
  br label %501

501:                                              ; preds = %499, %494
  %502 = phi ptr [ %500, %499 ], [ %498, %494 ]
  %503 = getelementptr inbounds nuw i8, ptr %502, i64 4096
  %504 = getelementptr inbounds nuw [16 x i8], ptr %4, i64 %484
  %505 = getelementptr inbounds nuw i8, ptr %504, i64 8
  %506 = load ptr, ptr %505, align 8, !tbaa !38
  %507 = icmp eq ptr %503, %506
  br i1 %507, label %508, label %518

508:                                              ; preds = %501
  %509 = getelementptr inbounds nuw [8 x i8], ptr %391, i64 %484
  store i32 %486, ptr %509, align 8, !tbaa !27
  %510 = load ptr, ptr %504, align 16, !tbaa !36
  %511 = ptrtoint ptr %503 to i64
  %512 = ptrtoint ptr %510 to i64
  %513 = sub i64 %511, %512
  %514 = lshr exact i64 %513, 3
  %515 = trunc i64 %514 to i32
  %516 = sub i32 512, %515
  %517 = getelementptr inbounds nuw i8, ptr %509, i64 4
  store i32 %516, ptr %517, align 4, !tbaa !29
  br label %518

518:                                              ; preds = %477, %508, %501, %386
  %519 = phi ptr [ %387, %386 ], [ %390, %501 ], [ %390, %508 ], [ %390, %477 ]
  %520 = getelementptr inbounds nuw [4 x i8], ptr %519, i64 %275
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 4 dereferenceable(1024) %384, ptr noundef nonnull align 4 dereferenceable(1024) %520, i64 1024, i1 false)
  %521 = add i64 %275, 256
  %522 = getelementptr inbounds nuw [4 x i8], ptr %384, i64 %521
  %523 = load ptr, ptr %6, align 8, !tbaa !16
  %524 = getelementptr inbounds nuw [4 x i8], ptr %523, i64 %521
  %525 = getelementptr inbounds nuw i8, ptr %0, i64 8
  %526 = load i64, ptr %525, align 8, !tbaa !15
  %527 = lshr i64 %526, 9
  %528 = sub i64 %527, %275
  %529 = shl i64 %528, 2
  %530 = add i64 %529, 1024
  tail call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 4 %522, ptr align 4 %524, i64 %530, i1 false)
  %531 = load i64, ptr %10, align 8, !tbaa !19
  %532 = add i64 %531, 256
  store i64 %532, ptr %10, align 8, !tbaa !19
  %533 = load ptr, ptr %6, align 8, !tbaa !16
  store ptr %533, ptr %383, align 8, !tbaa !17
  store ptr %384, ptr %6, align 8, !tbaa !16
  call void @llvm.lifetime.end.p0(ptr nonnull %3) #12
  call void @llvm.lifetime.end.p0(ptr nonnull %5) #12
  call void @llvm.lifetime.end.p0(ptr nonnull %4) #12
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

declare i32 @always_supported() #5

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite, errnomem: write)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #6

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite, errnomem: write)
declare noalias noundef ptr @calloc(i64 noundef, i64 noundef) local_unnamed_addr #7

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #8

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memmove.p0.p0.i64(ptr writeonly captures(none), ptr readonly captures(none), i64, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #9

attributes #0 = { nounwind sspstrong uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="znver4" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vpopcntdq,+bmi,+bmi2,+clflushopt,+clwb,+clzero,+cmov,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+gfni,+invpcid,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+pku,+popcnt,+prfchw,+rdpid,+rdpru,+rdrnd,+rdseed,+sahf,+sha,+shstk,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+wbnoinvd,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-amx-avx512,-amx-bf16,-amx-complex,-amx-fp16,-amx-fp8,-amx-int8,-amx-movrs,-amx-tile,-avx10.1,-avx10.2,-avx512bmm,-avx512fp16,-avx512vp2intersect,-avxifma,-avxneconvert,-avxvnni,-avxvnniint16,-avxvnniint8,-ccmp,-cf,-cldemote,-cmpccxadd,-egpr,-enqcmd,-fma4,-hreset,-jmpabs,-kl,-lwp,-movdir64b,-movdiri,-movrs,-ndd,-nf,-pconfig,-ppx,-prefetchi,-ptwrite,-push2pop2,-raoint,-rtm,-serialize,-sgx,-sha512,-sm3,-sm4,-tbm,-tsxldtrk,-uintr,-usermsr,-waitpkg,-widekl,-xop,-zu" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { cold nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="znver4" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vpopcntdq,+bmi,+bmi2,+clflushopt,+clwb,+clzero,+cmov,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+gfni,+invpcid,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+pku,+popcnt,+prfchw,+rdpid,+rdpru,+rdrnd,+rdseed,+sahf,+sha,+shstk,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+wbnoinvd,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-amx-avx512,-amx-bf16,-amx-complex,-amx-fp16,-amx-fp8,-amx-int8,-amx-movrs,-amx-tile,-avx10.1,-avx10.2,-avx512bmm,-avx512fp16,-avx512vp2intersect,-avxifma,-avxneconvert,-avxvnni,-avxvnniint16,-avxvnniint8,-ccmp,-cf,-cldemote,-cmpccxadd,-egpr,-enqcmd,-fma4,-hreset,-jmpabs,-kl,-lwp,-movdir64b,-movdiri,-movrs,-ndd,-nf,-pconfig,-ppx,-prefetchi,-ptwrite,-push2pop2,-raoint,-rtm,-serialize,-sgx,-sha512,-sm3,-sm4,-tbm,-tsxldtrk,-uintr,-usermsr,-waitpkg,-widekl,-xop,-zu" }
attributes #3 = { cold nofree noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="znver4" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vpopcntdq,+bmi,+bmi2,+clflushopt,+clwb,+clzero,+cmov,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+gfni,+invpcid,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+pku,+popcnt,+prfchw,+rdpid,+rdpru,+rdrnd,+rdseed,+sahf,+sha,+shstk,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+wbnoinvd,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-amx-avx512,-amx-bf16,-amx-complex,-amx-fp16,-amx-fp8,-amx-int8,-amx-movrs,-amx-tile,-avx10.1,-avx10.2,-avx512bmm,-avx512fp16,-avx512vp2intersect,-avxifma,-avxneconvert,-avxvnni,-avxvnniint16,-avxvnniint8,-ccmp,-cf,-cldemote,-cmpccxadd,-egpr,-enqcmd,-fma4,-hreset,-jmpabs,-kl,-lwp,-movdir64b,-movdiri,-movrs,-ndd,-nf,-pconfig,-ppx,-prefetchi,-ptwrite,-push2pop2,-raoint,-rtm,-serialize,-sgx,-sha512,-sm3,-sm4,-tbm,-tsxldtrk,-uintr,-usermsr,-waitpkg,-widekl,-xop,-zu" }
attributes #4 = { nofree norecurse nosync nounwind sspstrong memory(readwrite, inaccessiblemem: none, target_mem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="znver4" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vpopcntdq,+bmi,+bmi2,+clflushopt,+clwb,+clzero,+cmov,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+gfni,+invpcid,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+pku,+popcnt,+prfchw,+rdpid,+rdpru,+rdrnd,+rdseed,+sahf,+sha,+shstk,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+wbnoinvd,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-amx-avx512,-amx-bf16,-amx-complex,-amx-fp16,-amx-fp8,-amx-int8,-amx-movrs,-amx-tile,-avx10.1,-avx10.2,-avx512bmm,-avx512fp16,-avx512vp2intersect,-avxifma,-avxneconvert,-avxvnni,-avxvnniint16,-avxvnniint8,-ccmp,-cf,-cldemote,-cmpccxadd,-egpr,-enqcmd,-fma4,-hreset,-jmpabs,-kl,-lwp,-movdir64b,-movdiri,-movrs,-ndd,-nf,-pconfig,-ppx,-prefetchi,-ptwrite,-push2pop2,-raoint,-rtm,-serialize,-sgx,-sha512,-sm3,-sm4,-tbm,-tsxldtrk,-uintr,-usermsr,-waitpkg,-widekl,-xop,-zu" }
attributes #5 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="znver4" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vpopcntdq,+bmi,+bmi2,+clflushopt,+clwb,+clzero,+cmov,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+gfni,+invpcid,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+pku,+popcnt,+prfchw,+rdpid,+rdpru,+rdrnd,+rdseed,+sahf,+sha,+shstk,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+wbnoinvd,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-amx-avx512,-amx-bf16,-amx-complex,-amx-fp16,-amx-fp8,-amx-int8,-amx-movrs,-amx-tile,-avx10.1,-avx10.2,-avx512bmm,-avx512fp16,-avx512vp2intersect,-avxifma,-avxneconvert,-avxvnni,-avxvnniint16,-avxvnniint8,-ccmp,-cf,-cldemote,-cmpccxadd,-egpr,-enqcmd,-fma4,-hreset,-jmpabs,-kl,-lwp,-movdir64b,-movdiri,-movrs,-ndd,-nf,-pconfig,-ppx,-prefetchi,-ptwrite,-push2pop2,-raoint,-rtm,-serialize,-sgx,-sha512,-sm3,-sm4,-tbm,-tsxldtrk,-uintr,-usermsr,-waitpkg,-widekl,-xop,-zu" }
attributes #6 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite, errnomem: write) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="znver4" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vpopcntdq,+bmi,+bmi2,+clflushopt,+clwb,+clzero,+cmov,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+gfni,+invpcid,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+pku,+popcnt,+prfchw,+rdpid,+rdpru,+rdrnd,+rdseed,+sahf,+sha,+shstk,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+wbnoinvd,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-amx-avx512,-amx-bf16,-amx-complex,-amx-fp16,-amx-fp8,-amx-int8,-amx-movrs,-amx-tile,-avx10.1,-avx10.2,-avx512bmm,-avx512fp16,-avx512vp2intersect,-avxifma,-avxneconvert,-avxvnni,-avxvnniint16,-avxvnniint8,-ccmp,-cf,-cldemote,-cmpccxadd,-egpr,-enqcmd,-fma4,-hreset,-jmpabs,-kl,-lwp,-movdir64b,-movdiri,-movrs,-ndd,-nf,-pconfig,-ppx,-prefetchi,-ptwrite,-push2pop2,-raoint,-rtm,-serialize,-sgx,-sha512,-sm3,-sm4,-tbm,-tsxldtrk,-uintr,-usermsr,-waitpkg,-widekl,-xop,-zu" }
attributes #7 = { mustprogress nofree nounwind willreturn allockind("alloc,zeroed") allocsize(0,1) memory(inaccessiblemem: readwrite, errnomem: write) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="znver4" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vpopcntdq,+bmi,+bmi2,+clflushopt,+clwb,+clzero,+cmov,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+gfni,+invpcid,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+pku,+popcnt,+prfchw,+rdpid,+rdpru,+rdrnd,+rdseed,+sahf,+sha,+shstk,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+wbnoinvd,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-amx-avx512,-amx-bf16,-amx-complex,-amx-fp16,-amx-fp8,-amx-int8,-amx-movrs,-amx-tile,-avx10.1,-avx10.2,-avx512bmm,-avx512fp16,-avx512vp2intersect,-avxifma,-avxneconvert,-avxvnni,-avxvnniint16,-avxvnniint8,-ccmp,-cf,-cldemote,-cmpccxadd,-egpr,-enqcmd,-fma4,-hreset,-jmpabs,-kl,-lwp,-movdir64b,-movdiri,-movrs,-ndd,-nf,-pconfig,-ppx,-prefetchi,-ptwrite,-push2pop2,-raoint,-rtm,-serialize,-sgx,-sha512,-sm3,-sm4,-tbm,-tsxldtrk,-uintr,-usermsr,-waitpkg,-widekl,-xop,-zu" }
attributes #8 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="znver4" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vpopcntdq,+bmi,+bmi2,+clflushopt,+clwb,+clzero,+cmov,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+gfni,+invpcid,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+pku,+popcnt,+prfchw,+rdpid,+rdpru,+rdrnd,+rdseed,+sahf,+sha,+shstk,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+wbnoinvd,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-amx-avx512,-amx-bf16,-amx-complex,-amx-fp16,-amx-fp8,-amx-int8,-amx-movrs,-amx-tile,-avx10.1,-avx10.2,-avx512bmm,-avx512fp16,-avx512vp2intersect,-avxifma,-avxneconvert,-avxvnni,-avxvnniint16,-avxvnniint8,-ccmp,-cf,-cldemote,-cmpccxadd,-egpr,-enqcmd,-fma4,-hreset,-jmpabs,-kl,-lwp,-movdir64b,-movdiri,-movrs,-ndd,-nf,-pconfig,-ppx,-prefetchi,-ptwrite,-push2pop2,-raoint,-rtm,-serialize,-sgx,-sha512,-sm3,-sm4,-tbm,-tsxldtrk,-uintr,-usermsr,-waitpkg,-widekl,-xop,-zu" }
attributes #9 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #10 = { nounwind allocsize(0) }
attributes #11 = { nounwind allocsize(0,1) }
attributes #12 = { nounwind }
attributes #13 = { cold }
attributes #14 = { cold noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}
!llvm.errno.tbaa = !{!4}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{!"clang version 23.1.1"}
!4 = !{!5, !6, i64 0}
!5 = !{!"__libc_errno", !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !11, i64 0}
!10 = !{!"sorter", !11, i64 0, !13, i64 8, !13, i64 16, !11, i64 24, !11, i64 32, !14, i64 40, !7, i64 48, !7, i64 2096}
!11 = !{!"p1 int", !12, i64 0}
!12 = !{!"any pointer", !7, i64 0}
!13 = !{!"long", !7, i64 0}
!14 = !{!"p1 omnipotent char", !12, i64 0}
!15 = !{!10, !13, i64 8}
!16 = !{!10, !11, i64 24}
!17 = !{!10, !11, i64 32}
!18 = !{!10, !14, i64 40}
!19 = !{!10, !13, i64 16}
!20 = !{!6, !6, i64 0}
!21 = distinct !{!21, !22, !23, !24}
!22 = !{!"llvm.loop.mustprogress"}
!23 = !{!"llvm.loop.isvectorized", i32 1}
!24 = !{!"llvm.loop.unroll.runtime.disable"}
!25 = !{!"branch_weights", i32 8, i32 56}
!26 = distinct !{!26, !22, !23, !24}
!27 = !{!28, !6, i64 0}
!28 = !{!"partial", !6, i64 0, !6, i64 4}
!29 = !{!28, !6, i64 4}
!30 = distinct !{!30, !22, !24, !23}
!31 = distinct !{!31, !22}
!32 = distinct !{!32, !33}
!33 = !{!"llvm.loop.unroll.disable"}
!34 = distinct !{!34, !22}
!35 = distinct !{!35, !22}
!36 = !{!37, !11, i64 0}
!37 = !{!"bucket", !11, i64 0, !11, i64 8}
!38 = !{!37, !11, i64 8}
!39 = !{!7, !7, i64 0}
!40 = distinct !{!40, !22}
!41 = distinct !{!41, !22}
!42 = distinct !{!42, !22}
!43 = distinct !{!43, !22}
!44 = distinct !{!44, !22}

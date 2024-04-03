// Copyright 2022 "Holloway" Chew, Kean Ho <kean.ho.chew@zoralab.com>
// Copyright 2022 ZORALab Enterprise <tech@zoralab.com>
// Copyright 2016 The Go Authors <https://cs.opensource.google/go/go>
//
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not
// use this file except in compliance with the License. You may obtain a copy of
// the License at
//
//                  http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations under
// the License.

//go:build !tinygo && (ppc64 || ppc64le)

#include "textflag.h"

#define Big		0x4330000000000000 // 2**52

// func _s64_Floor_FLOAT64(input float64) (round float64)
TEXT ·_s64_Floor_FLOAT64(SB),NOSPLIT,$0
	FMOVD   x+0(FP), F0
	FRIM	F0, F0
	FMOVD   F0, ret+8(FP)
	RET

// func _s64_Modf_FLOAT64(input float64) (round float64, fraction float64)
TEXT ·_s64_Modf_FLOAT64(SB),NOSPLIT,$0
	FMOVD	f+0(FP), F0
	FRIZ	F0, F1
	FMOVD	F1, int+8(FP)
	FSUB	F1, F0, F2
	FCPSGN	F2, F0, F2
	FMOVD	F2, frac+16(FP)
	RET

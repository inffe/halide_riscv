	.text
	.attribute	4, 16
	.attribute	5, "rv64gcv0p7"
	.file	"halide_buffer_t.cpp"
	.section	.sdata,"aw",@progbits
	.p2align	2                               # -- Begin function halide_julia_rv
.LCPI0_0:
	.word	0xc0000000                      # float -2
.LCPI0_1:
	.word	0x3ca3d70a                      # float 0.0199999996
.LCPI0_2:
	.word	0x40000000                      # float 2
.LCPI0_3:
	.word	0xbf400000                      # float -0.75
.LCPI0_4:
	.word	0x40800000                      # float 4
	.section	.text.halide_julia_rv,"ax",@progbits
	.globl	halide_julia_rv
	.p2align	1
	.type	halide_julia_rv,@function
halide_julia_rv:                        # @halide_julia_rv
# %bb.0:                                # %entry
	addi	sp, sp, -176
	sd	ra, 168(sp)                     # 8-byte Folded Spill
	sd	s0, 160(sp)                     # 8-byte Folded Spill
	sd	s1, 152(sp)                     # 8-byte Folded Spill
	sd	s2, 144(sp)                     # 8-byte Folded Spill
	sd	s3, 136(sp)                     # 8-byte Folded Spill
	sd	s4, 128(sp)                     # 8-byte Folded Spill
	sd	s5, 120(sp)                     # 8-byte Folded Spill
	sd	s6, 112(sp)                     # 8-byte Folded Spill
	sd	s7, 104(sp)                     # 8-byte Folded Spill
	sd	s8, 96(sp)                      # 8-byte Folded Spill
	sd	s9, 88(sp)                      # 8-byte Folded Spill
	sd	s10, 80(sp)                     # 8-byte Folded Spill
	sd	s11, 72(sp)                     # 8-byte Folded Spill
	fsd	fs0, 64(sp)                     # 8-byte Folded Spill
	fsd	fs1, 56(sp)                     # 8-byte Folded Spill
	ld	a1, 40(a0)
	ld	s3, 16(a0)
	lw	s4, 0(a1)
	lwu	s9, 4(a1)
	lw	a2, 16(a1)
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	lwu	a2, 20(a1)
	lw	a3, 24(a1)
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	sext.w	a3, s9
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	sext.w	a2, a2
	bnez	s3, .LBB0_2
# %bb.1:                                # %_halide_buffer_is_bounds_query.exit
	ld	a3, 0(a0)
	beqz	a3, .LBB0_26
.LBB0_2:                                # %"produce f0"
	blez	a2, .LBB0_27
.LBB0_3:                                # %"for f0.s0.v1.rebased.preheader"
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	addiw	a0, a1, -1
	andi	s7, a0, -4
	negw	s8, s7
	li	a2, -4
	addiw	a0, a1, 3
	mv	a1, s7
	blt	a2, s7, .LBB0_5
# %bb.4:                                # %"for f0.s0.v1.rebased.preheader"
	li	a1, -4
.LBB0_5:                                # %"for f0.s0.v1.rebased.preheader"
	li	a2, 0
	addiw	a1, a1, 4
	slli	a1, a1, 32
	srli	a1, a1, 22
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	addiw	s7, s7, 4
	slli	a0, a0, 30
	srli	s6, a0, 32
	slli	s11, s7, 2
.Lpcrel_hi0:
	auipc	a0, %pcrel_hi(.LCPI0_0)
	flw	fs0, %pcrel_lo(.Lpcrel_hi0)(a0)
.Lpcrel_hi1:
	auipc	a0, %pcrel_hi(.LCPI0_1)
	flw	fs1, %pcrel_lo(.Lpcrel_hi1)(a0)
	add	s8, s8, s7
	li	s2, 4
	j	.LBB0_7
.LBB0_6:                                # %call_destructor.exit35
                                        #   in Loop: Header=BB0_7 Depth=1
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	addi	a2, a2, 1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	beq	a2, a0, .LBB0_27
.LBB0_7:                                # %"for f0.s0.v1.rebased"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_9 Depth 2
                                        #       Child Loop BB0_10 Depth 3
                                        #     Child Loop BB0_13 Depth 2
                                        #       Child Loop BB0_14 Depth 3
                                        #     Child Loop BB0_18 Depth 2
                                        #       Child Loop BB0_20 Depth 3
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	ld	s0, 8(sp)                       # 8-byte Folded Reload
	mv	a1, s0
	call	halide_malloc@plt
	mv	s10, a0
	li	a0, 0
	mv	a1, s0
	call	halide_malloc@plt
	mv	s5, a0
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	blez	a0, .LBB0_22
# %bb.8:                                # %"for julia.s0.v2.us.preheader"
                                        #   in Loop: Header=BB0_7 Depth=1
	li	a0, 0
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	t0, 48(sp)                      # 8-byte Folded Reload
	add	a1, a1, t0
	fcvt.s.w	ft0, a1
	fmadd.s	ft0, ft0, fs1, fs0
	mv	a1, s10
	mv	a2, s5
	li	s0, 256
.LBB0_9:                                # %"for julia.s0.v2.us"
                                        #   Parent Loop BB0_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_10 Depth 3
	mv	a3, s4
	mv	a4, a1
	mv	a5, a2
	mv	s1, s9
.LBB0_10:                               # %"for julia.s0.v0.rebased.us"
                                        #   Parent Loop BB0_7 Depth=1
                                        #     Parent Loop BB0_9 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	fcvt.s.w	ft1, a3
	fmadd.s	ft1, ft1, fs1, fs0
	fsw	ft1, 0(a4)
	fsw	ft0, 0(a5)
	addi	s1, s1, -1
	addi	a5, a5, 4
	addi	a4, a4, 4
	addiw	a3, a3, 1
	bnez	s1, .LBB0_10
# %bb.11:                               # %"end for julia.s0.v0.rebased.us"
                                        #   in Loop: Header=BB0_9 Depth=2
	addi	a0, a0, 1
	add	a2, a2, s11
	add	a1, a1, s11
	bne	a0, s0, .LBB0_9
# %bb.12:                               # %"for julia.s1.v0.v0.preheader"
                                        #   in Loop: Header=BB0_7 Depth=1
	li	a0, 0
	li	a1, 0
	addi	a6, s5, -16
	addi	a7, s10, -16
.LBB0_13:                               # %"for julia.s1.v0.v0"
                                        #   Parent Loop BB0_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_14 Depth 3
	add	a2, s7, a0
	slli	a2, a2, 2
	add	a4, s5, a2
	add	a5, s10, a2
	add	a2, s8, a0
	slli	a3, a2, 2
	add	a2, a6, a3
	add	a3, a3, a7
	li	s0, 255
.LBB0_14:                               # %"for julia.s1.r7$x.rebased"
                                        #   Parent Loop BB0_7 Depth=1
                                        #     Parent Loop BB0_13 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vsetvli	zero, s2, e32, m1
	vlwu.v	v8, (a3)
	vlwu.v	v9, (a2)
	vfmul.vv	v8, v8, v8
	vfmul.vv	v10, v9, v9
	vfsub.vv	v8, v8, v10
	vsw.v	v8, (a5)
	vlwu.v	v8, (a3)
.Lpcrel_hi2:
	auipc	s1, %pcrel_hi(.LCPI0_2)
	flw	ft0, %pcrel_lo(.Lpcrel_hi2)(s1)
.Lpcrel_hi3:
	auipc	s1, %pcrel_hi(.LCPI0_3)
	flw	ft1, %pcrel_lo(.Lpcrel_hi3)(s1)
	vfmul.vv	v8, v8, v9
	vfmul.vf	v8, v8, ft0
	vfadd.vf	v8, v8, ft1
	vsw.v	v8, (a4)
	addi	s0, s0, -1
	add	a4, a4, s11
	add	a5, a5, s11
	add	a2, a2, s11
	add	a3, a3, s11
	bnez	s0, .LBB0_14
# %bb.15:                               # %"end for julia.s1.r7$x.rebased"
                                        #   in Loop: Header=BB0_13 Depth=2
	addi	a1, a1, 1
	addiw	a0, a0, 4
	bne	a1, s6, .LBB0_13
# %bb.16:                               # %"consume julia"
                                        #   in Loop: Header=BB0_7 Depth=1
	li	a0, 0
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	mulw	a6, a1, t0
	add	a7, s5, s11
	add	t0, s10, s11
	j	.LBB0_18
.LBB0_17:                               # %"consume argmin"
                                        #   in Loop: Header=BB0_18 Depth=2
	add	a1, a0, a6
	add	a1, a1, s3
	sb	a4, 0(a1)
	addi	a0, a0, 1
	addi	a7, a7, 4
	addi	t0, t0, 4
	beq	a0, s9, .LBB0_23
.LBB0_18:                               # %"for f0.s0.v0.rebased"
                                        #   Parent Loop BB0_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_20 Depth 3
	li	a4, 0
	li	a5, 1
	li	s0, 255
	mv	a3, t0
	mv	a2, a7
	li	a1, 1
	j	.LBB0_20
.LBB0_19:                               # %"for argmin.s1.r7$x.rebased"
                                        #   in Loop: Header=BB0_20 Depth=3
	addi	s0, s0, -1
	addiw	a5, a5, 1
	add	a2, a2, s11
	add	a3, a3, s11
	beqz	s0, .LBB0_17
.LBB0_20:                               # %"for argmin.s1.r7$x.rebased"
                                        #   Parent Loop BB0_7 Depth=1
                                        #     Parent Loop BB0_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	flw	ft1, 0(a3)
	flw	ft2, 0(a2)
.Lpcrel_hi4:
	auipc	s1, %pcrel_hi(.LCPI0_4)
	flw	ft0, %pcrel_lo(.Lpcrel_hi4)(s1)
	fmul.s	ft1, ft1, ft1
	fmadd.s	ft1, ft2, ft2, ft1
	fle.s	s1, ft0, ft1
	and	s1, s1, a1
	beqz	s1, .LBB0_19
# %bb.21:                               #   in Loop: Header=BB0_20 Depth=3
	flt.s	a1, ft1, ft0
	mv	a4, a5
	j	.LBB0_19
.LBB0_22:                               # %"for julia.s0.v2.preheader"
                                        #   in Loop: Header=BB0_7 Depth=1
	beqz	s10, .LBB0_24
.LBB0_23:                               # %if.then.i
                                        #   in Loop: Header=BB0_7 Depth=1
	li	a0, 0
	mv	a1, s10
	call	halide_free@plt
.LBB0_24:                               # %call_destructor.exit
                                        #   in Loop: Header=BB0_7 Depth=1
	beqz	s5, .LBB0_6
# %bb.25:                               # %if.then.i34
                                        #   in Loop: Header=BB0_7 Depth=1
	li	a0, 0
	mv	a1, s5
	call	halide_free@plt
	j	.LBB0_6
.LBB0_26:                               # %_halide_buffer_is_bounds_query.exit27
	sd	zero, 16(a0)
	sd	zero, 8(a0)
	sd	zero, 0(a0)
	lui	a3, 512
	addiw	a3, a3, 17
	slli	a3, a3, 12
	addi	a3, a3, -2047
	sd	a3, 32(a0)
	li	a3, 1
	sw	a3, 8(a1)
	sw	zero, 12(a1)
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	sw	a3, 24(a1)
	sw	zero, 28(a1)
	ld	a1, 0(a0)
	snez	a1, a1
	sgtz	a2, a2
	and	a1, a1, a2
	sd	zero, 24(a0)
	bnez	a1, .LBB0_3
.LBB0_27:                               # %destructor_block
	li	a0, 0
	ld	ra, 168(sp)                     # 8-byte Folded Reload
	ld	s0, 160(sp)                     # 8-byte Folded Reload
	ld	s1, 152(sp)                     # 8-byte Folded Reload
	ld	s2, 144(sp)                     # 8-byte Folded Reload
	ld	s3, 136(sp)                     # 8-byte Folded Reload
	ld	s4, 128(sp)                     # 8-byte Folded Reload
	ld	s5, 120(sp)                     # 8-byte Folded Reload
	ld	s6, 112(sp)                     # 8-byte Folded Reload
	ld	s7, 104(sp)                     # 8-byte Folded Reload
	ld	s8, 96(sp)                      # 8-byte Folded Reload
	ld	s9, 88(sp)                      # 8-byte Folded Reload
	ld	s10, 80(sp)                     # 8-byte Folded Reload
	ld	s11, 72(sp)                     # 8-byte Folded Reload
	fld	fs0, 64(sp)                     # 8-byte Folded Reload
	fld	fs1, 56(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 176
	ret
.Lfunc_end0:
	.size	halide_julia_rv, .Lfunc_end0-halide_julia_rv
                                        # -- End function
	.section	.text.halide_julia_rv_argv,"ax",@progbits
	.globl	halide_julia_rv_argv            # -- Begin function halide_julia_rv_argv
	.p2align	1
	.type	halide_julia_rv_argv,@function
halide_julia_rv_argv:                   # @halide_julia_rv_argv
# %bb.0:                                # %entry
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	ld	a0, 0(a0)
	call	halide_julia_rv@plt
	li	a0, 0
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	halide_julia_rv_argv, .Lfunc_end1-halide_julia_rv_argv
                                        # -- End function
	.section	.text.halide_julia_rv_metadata,"ax",@progbits
	.globl	halide_julia_rv_metadata        # -- Begin function halide_julia_rv_metadata
	.p2align	1
	.type	halide_julia_rv_metadata,@function
halide_julia_rv_metadata:               # @halide_julia_rv_metadata
# %bb.0:                                # %entry
.Lpcrel_hi5:
	auipc	a0, %pcrel_hi(.Lhalide_julia_rv_metadata_storage)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi5)
	ret
.Lfunc_end2:
	.size	halide_julia_rv_metadata, .Lfunc_end2-halide_julia_rv_metadata
                                        # -- End function
	.type	.L__unnamed_1,@object           # @0
	.section	.rodata,"a",@progbits
	.p2align	4, 0x0
.L__unnamed_1:
	.zero	32
	.size	.L__unnamed_1, 32

	.type	.Lstr,@object                   # @str
	.p2align	5, 0x0
.Lstr:
	.asciz	"f0"
	.size	.Lstr, 3

	.type	.L__unnamed_2,@object           # @1
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
.L__unnamed_2:
	.quad	.Lstr
	.word	2                               # 0x2
	.word	2                               # 0x2
	.byte	1                               # 0x1
	.byte	8                               # 0x8
	.half	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_1
	.size	.L__unnamed_2, 64

	.type	.Lstr.4,@object                 # @str.4
	.section	.rodata,"a",@progbits
	.p2align	5, 0x0
.Lstr.4:
	.asciz	"riscv-64-linux-no_asserts-no_runtime-rvv-vector_bits_128"
	.size	.Lstr.4, 57

	.type	.Lstr.5,@object                 # @str.5
	.p2align	5, 0x0
.Lstr.5:
	.asciz	"halide_julia_rv"
	.size	.Lstr.5, 16

	.type	.Lhalide_julia_rv_metadata_storage,@object # @halide_julia_rv_metadata_storage
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
.Lhalide_julia_rv_metadata_storage:
	.word	1                               # 0x1
	.word	1                               # 0x1
	.quad	.L__unnamed_2
	.quad	.Lstr.4
	.quad	.Lstr.5
	.size	.Lhalide_julia_rv_metadata_storage, 32

	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.section	".note.GNU-stack","",@progbits

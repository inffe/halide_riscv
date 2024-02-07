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
	.word	0xbf400000                      # float -0.75
.LCPI0_3:
	.word	0x40800000                      # float 4
	.section	.text.halide_julia_rv,"ax",@progbits
	.globl	halide_julia_rv
	.p2align	1
	.type	halide_julia_rv,@function
halide_julia_rv:                        # @halide_julia_rv
# %bb.0:                                # %entry
	addi	sp, sp, -96
	sd	ra, 88(sp)                      # 8-byte Folded Spill
	sd	s0, 80(sp)                      # 8-byte Folded Spill
	sd	s1, 72(sp)                      # 8-byte Folded Spill
	sd	s2, 64(sp)                      # 8-byte Folded Spill
	sd	s3, 56(sp)                      # 8-byte Folded Spill
	sd	s4, 48(sp)                      # 8-byte Folded Spill
	sd	s5, 40(sp)                      # 8-byte Folded Spill
	sd	s6, 32(sp)                      # 8-byte Folded Spill
	sd	s7, 24(sp)                      # 8-byte Folded Spill
	sd	s8, 16(sp)                      # 8-byte Folded Spill
	sd	s9, 8(sp)                       # 8-byte Folded Spill
	sd	s10, 0(sp)                      # 8-byte Folded Spill
	ld	a1, 40(a0)
	ld	s6, 16(a0)
	lw	s7, 0(a1)
	lw	s9, 4(a1)
	lw	s8, 16(a1)
	lwu	s4, 20(a1)
	lw	s5, 24(a1)
	bnez	s6, .LBB0_3
# %bb.1:                                # %_halide_buffer_is_bounds_query.exit
	ld	a2, 0(a0)
	bnez	a2, .LBB0_3
# %bb.2:                                # %_halide_buffer_is_bounds_query.exit31
	sd	zero, 16(a0)
	sd	zero, 8(a0)
	sd	zero, 0(a0)
	lui	a2, 512
	addiw	a2, a2, 17
	slli	a2, a2, 12
	addi	a2, a2, -2047
	sd	a2, 32(a0)
	li	a2, 1
	sw	a2, 8(a1)
	sw	zero, 12(a1)
	sw	s9, 24(a1)
	sw	zero, 28(a1)
	ld	a1, 0(a0)
	sd	zero, 24(a0)
	beqz	a1, .LBB0_30
.LBB0_3:                                # %then_bb2
	sext.w	s10, s4
	slti	s0, s9, 1
	sgtz	a0, s9
	neg	a0, a0
	and	a0, a0, s9
	slti	s1, s10, 1
	sgtz	a1, s10
	neg	a1, a1
	and	a1, a1, s10
	mul	s3, a0, a1
	slli	s3, s3, 10
	li	a0, 0
	mv	a1, s3
	call	halide_malloc@plt
	mv	s2, a0
	li	a0, 0
	mv	a1, s3
	call	halide_malloc@plt
	or	s0, s0, s1
	mv	s3, a0
	bnez	s0, .LBB0_26
# %bb.4:                                # %"for julia.s0.v2.us.us.preheader"
	li	a7, 0
	mulw	a0, s10, s9
.Lpcrel_hi0:
	auipc	a1, %pcrel_hi(.LCPI0_0)
	flw	ft0, %pcrel_lo(.Lpcrel_hi0)(a1)
.Lpcrel_hi1:
	auipc	a1, %pcrel_hi(.LCPI0_1)
	flw	ft1, %pcrel_lo(.Lpcrel_hi1)(a1)
	slli	a0, a0, 2
	slli	t3, s9, 2
	li	a6, 256
	mv	t0, s2
	mv	t1, s3
.LBB0_5:                                # %"for julia.s0.v2.us.us"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_6 Depth 2
                                        #       Child Loop BB0_7 Depth 3
	li	a3, 0
	mv	s0, t0
	mv	a2, t1
.LBB0_6:                                # %"for julia.s0.v1.rebased.us.us.us"
                                        #   Parent Loop BB0_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_7 Depth 3
	add	a1, s8, a3
	fcvt.s.w	ft2, a1
	fmadd.s	ft2, ft2, ft1, ft0
	mv	a1, s7
	mv	a4, s0
	mv	a5, a2
	mv	s1, s9
.LBB0_7:                                # %"for julia.s0.v0.rebased.us.us.us"
                                        #   Parent Loop BB0_5 Depth=1
                                        #     Parent Loop BB0_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	fcvt.s.w	ft3, a1
	fmadd.s	ft3, ft3, ft1, ft0
	fsw	ft3, 0(a4)
	fsw	ft2, 0(a5)
	addi	s1, s1, -1
	addi	a5, a5, 4
	addi	a4, a4, 4
	addiw	a1, a1, 1
	bnez	s1, .LBB0_7
# %bb.8:                                # %"end for julia.s0.v0.rebased.loopexit.us.us.us"
                                        #   in Loop: Header=BB0_6 Depth=2
	addi	a3, a3, 1
	add	a2, a2, t3
	add	s0, s0, t3
	bne	a3, s10, .LBB0_6
# %bb.9:                                # %"end for julia.s0.v1.rebased.split.us.us.us"
                                        #   in Loop: Header=BB0_5 Depth=1
	addi	a7, a7, 1
	add	t1, t1, a0
	add	t0, t0, a0
	bne	a7, a6, .LBB0_5
# %bb.10:                               # %"for julia.s1.v1.rebased.preheader"
	blez	s9, .LBB0_27
# %bb.11:                               # %"for julia.s1.v1.rebased.us.preheader"
.Lpcrel_hi2:
	auipc	a1, %pcrel_hi(.LCPI0_2)
	flw	ft0, %pcrel_lo(.Lpcrel_hi2)(a1)
	li	a6, 0
	add	a7, s3, a0
	add	t0, s2, a0
	mv	t1, s2
	mv	t2, s3
.LBB0_12:                               # %"for julia.s1.v1.rebased.us"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_13 Depth 2
                                        #       Child Loop BB0_14 Depth 3
	li	t4, 0
	mv	t5, t1
	mv	t6, t2
	mv	s0, t0
	mv	a2, a7
.LBB0_13:                               # %"for julia.s1.v0.rebased.us"
                                        #   Parent Loop BB0_12 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_14 Depth 3
	li	a1, 255
	mv	a5, t5
	mv	s1, t6
	mv	a3, s0
	mv	a4, a2
.LBB0_14:                               # %"for julia.s1.r7$x.rebased.us"
                                        #   Parent Loop BB0_12 Depth=1
                                        #     Parent Loop BB0_13 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	flw	ft1, 0(s1)
	flw	ft2, 0(a5)
	fmul.s	ft3, ft1, ft1
	fmsub.s	ft2, ft2, ft2, ft3
	fsw	ft2, 0(a3)
	flw	ft2, 0(a5)
	fadd.s	ft1, ft1, ft1
	fmadd.s	ft1, ft1, ft2, ft0
	fsw	ft1, 0(a4)
	addi	a1, a1, -1
	add	a4, a4, a0
	add	a3, a3, a0
	add	s1, s1, a0
	add	a5, a5, a0
	bnez	a1, .LBB0_14
# %bb.15:                               # %"end for julia.s1.r7$x.rebased.us"
                                        #   in Loop: Header=BB0_13 Depth=2
	addi	t4, t4, 1
	addi	a2, a2, 4
	addi	s0, s0, 4
	addi	t6, t6, 4
	addi	t5, t5, 4
	bne	t4, s9, .LBB0_13
# %bb.16:                               # %"end for julia.s1.v0.rebased.loopexit.us"
                                        #   in Loop: Header=BB0_12 Depth=1
	addi	a6, a6, 1
	add	a7, a7, t3
	add	t0, t0, t3
	add	t2, t2, t3
	add	t1, t1, t3
	bne	a6, s4, .LBB0_12
# %bb.17:                               # %"for f0.s0.v1.rebased.preheader"
	blez	s9, .LBB0_27
# %bb.18:                               # %"for f0.s0.v1.rebased.us.preheader"
.Lpcrel_hi3:
	auipc	a1, %pcrel_hi(.LCPI0_3)
	flw	ft0, %pcrel_lo(.Lpcrel_hi3)(a1)
	li	t0, 0
	add	a6, s3, a0
	add	a7, s2, a0
	j	.LBB0_20
.LBB0_19:                               # %"end for f0.s0.v0.rebased.loopexit.us"
                                        #   in Loop: Header=BB0_20 Depth=1
	addi	t0, t0, 1
	add	a6, a6, t3
	add	a7, a7, t3
	beq	t0, s4, .LBB0_27
.LBB0_20:                               # %"for f0.s0.v1.rebased.us"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_22 Depth 2
                                        #       Child Loop BB0_24 Depth 3
	li	t5, 0
	mulw	t1, s5, t0
	mv	t2, a7
	mv	t4, a6
	j	.LBB0_22
.LBB0_21:                               # %"consume argmin.us"
                                        #   in Loop: Header=BB0_22 Depth=2
	add	a2, t5, t1
	add	a2, a2, s6
	sb	a1, 0(a2)
	addi	t5, t5, 1
	addi	t4, t4, 4
	addi	t2, t2, 4
	beq	t5, s9, .LBB0_19
.LBB0_22:                               # %"for f0.s0.v0.rebased.us"
                                        #   Parent Loop BB0_20 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_24 Depth 3
	li	a1, 0
	li	a2, 1
	li	s0, 255
	mv	a4, t2
	mv	a3, t4
	li	s1, 1
	j	.LBB0_24
.LBB0_23:                               # %"for argmin.s1.r7$x.rebased.us"
                                        #   in Loop: Header=BB0_24 Depth=3
	addi	s0, s0, -1
	addiw	a2, a2, 1
	add	a3, a3, a0
	add	a4, a4, a0
	beqz	s0, .LBB0_21
.LBB0_24:                               # %"for argmin.s1.r7$x.rebased.us"
                                        #   Parent Loop BB0_20 Depth=1
                                        #     Parent Loop BB0_22 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	flw	ft1, 0(a4)
	flw	ft2, 0(a3)
	fmul.s	ft1, ft1, ft1
	fmadd.s	ft1, ft2, ft2, ft1
	fle.s	a5, ft0, ft1
	and	a5, a5, s1
	beqz	a5, .LBB0_23
# %bb.25:                               #   in Loop: Header=BB0_24 Depth=3
	flt.s	s1, ft1, ft0
	mv	a1, a2
	j	.LBB0_23
.LBB0_26:                               # %"end for f0.s0.v1.rebased"
	beqz	s2, .LBB0_28
.LBB0_27:                               # %if.then.i
	li	a0, 0
	mv	a1, s2
	call	halide_free@plt
.LBB0_28:                               # %call_destructor.exit
	beqz	s3, .LBB0_30
# %bb.29:                               # %if.then.i38
	li	a0, 0
	mv	a1, s3
	call	halide_free@plt
.LBB0_30:                               # %destructor_block
	li	a0, 0
	ld	ra, 88(sp)                      # 8-byte Folded Reload
	ld	s0, 80(sp)                      # 8-byte Folded Reload
	ld	s1, 72(sp)                      # 8-byte Folded Reload
	ld	s2, 64(sp)                      # 8-byte Folded Reload
	ld	s3, 56(sp)                      # 8-byte Folded Reload
	ld	s4, 48(sp)                      # 8-byte Folded Reload
	ld	s5, 40(sp)                      # 8-byte Folded Reload
	ld	s6, 32(sp)                      # 8-byte Folded Reload
	ld	s7, 24(sp)                      # 8-byte Folded Reload
	ld	s8, 16(sp)                      # 8-byte Folded Reload
	ld	s9, 8(sp)                       # 8-byte Folded Reload
	ld	s10, 0(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 96
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
.Lpcrel_hi4:
	auipc	a0, %pcrel_hi(.Lhalide_julia_rv_metadata_storage)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi4)
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
	.asciz	"riscv-64-linux-no_asserts-no_runtime"
	.size	.Lstr.4, 37

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

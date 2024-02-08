	.text
	.attribute	4, 16
	.attribute	5, "rv64gcv0p7"
	.file	"halide_buffer_t.cpp"
	.section	.text.ascii_art,"ax",@progbits
	.globl	ascii_art                       # -- Begin function ascii_art
	.p2align	1
	.type	ascii_art,@function
ascii_art:                              # @ascii_art
# %bb.0:                                # %entry
	addi	sp, sp, -32
	sd	s0, 24(sp)                      # 8-byte Folded Spill
	sd	s1, 16(sp)                      # 8-byte Folded Spill
	sd	s2, 8(sp)                       # 8-byte Folded Spill
	ld	a2, 40(a1)
	ld	t4, 16(a1)
	lw	t5, 4(a2)
	lw	t1, 24(a2)
	ld	a6, 16(a0)
	bnez	t4, .LBB0_2
# %bb.1:                                # %_halide_buffer_is_bounds_query.exit
	ld	a3, 0(a1)
	beqz	a3, .LBB0_5
.LBB0_2:                                # %after_bb
	lw	t2, 20(a2)
	lw	t0, 0(a2)
	lw	a7, 16(a2)
	bnez	a6, .LBB0_6
.LBB0_3:                                # %_halide_buffer_is_bounds_query.exit38
	ld	a2, 0(a0)
	bnez	a2, .LBB0_6
# %bb.4:                                # %then_bb2
	ld	a2, 40(a0)
	sd	zero, 16(a0)
	sd	zero, 8(a0)
	sd	zero, 0(a0)
	lui	a3, 512
	addiw	a3, a3, 17
	slli	a3, a3, 12
	addi	a3, a3, -2047
	sd	a3, 32(a0)
	sw	zero, 0(a2)
	li	a3, 543
	sw	a3, 4(a2)
	li	a4, 1
	sw	a4, 8(a2)
	sw	zero, 12(a2)
	sw	zero, 16(a2)
	li	a4, 360
	sw	a4, 20(a2)
	sw	a3, 24(a2)
	sw	zero, 28(a2)
	sd	zero, 24(a0)
	j	.LBB0_6
.LBB0_5:                                # %then_bb
	sd	zero, 16(a1)
	sd	zero, 8(a1)
	sd	zero, 0(a1)
	lui	a3, 512
	addiw	a3, a3, 17
	slli	a3, a3, 12
	addi	a3, a3, -2047
	sd	a3, 32(a1)
	li	a3, 1
	sw	a3, 8(a2)
	sw	zero, 12(a2)
	sw	t5, 24(a2)
	sw	zero, 28(a2)
	sd	zero, 24(a1)
	lw	t2, 20(a2)
	lw	t0, 0(a2)
	lw	a7, 16(a2)
	beqz	a6, .LBB0_3
.LBB0_6:                                # %after_bb1
	beqz	t4, .LBB0_9
# %bb.7:
	li	a1, 0
	beqz	a6, .LBB0_10
.LBB0_8:
	li	a0, 0
	j	.LBB0_11
.LBB0_9:                                # %land.rhs.i45
	ld	a1, 0(a1)
	seqz	a1, a1
	bnez	a6, .LBB0_8
.LBB0_10:                               # %land.rhs.i50
	ld	a0, 0(a0)
	seqz	a0, a0
.LBB0_11:                               # %_halide_buffer_is_bounds_query.exit51
	or	a0, a0, a1
	sgtz	a1, t2
	not	a0, a0
	and	a0, a0, a1
	sgtz	a1, t5
	and	a0, a0, a1
	beqz	a0, .LBB0_20
# %bb.12:                               # %"for ascii_art.s0.y.rebased.us.preheader"
	li	t3, 0
	slli	a0, t0, 4
	sub	a0, a0, t0
	lui	a1, 3
	addiw	t0, a1, -1971
	mul	a1, a7, t0
	add	a1, a1, a6
	add	a6, a1, a0
	li	a5, 19
	lui	a0, 835182
	addiw	a7, a0, -1695
	slli	a7, a7, 32
.LBB0_13:                               # %"for ascii_art.s0.y.rebased.us"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_14 Depth 2
                                        #       Child Loop BB0_15 Depth 3
                                        #         Child Loop BB0_16 Depth 4
	li	a1, 0
	mulw	t6, t1, t3
	mv	s2, a6
.LBB0_14:                               # %"for ascii_art.s0.x.rebased.us"
                                        #   Parent Loop BB0_13 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_15 Depth 3
                                        #         Child Loop BB0_16 Depth 4
	li	a4, 0
	li	a0, 0
	mv	a2, s2
.LBB0_15:                               # %"for sum.s1.r4$y.us"
                                        #   Parent Loop BB0_13 Depth=1
                                        #     Parent Loop BB0_14 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_16 Depth 4
	li	s0, 15
	mv	s1, a2
.LBB0_16:                               # %"for sum.s1.r4$x.us"
                                        #   Parent Loop BB0_13 Depth=1
                                        #     Parent Loop BB0_14 Depth=2
                                        #       Parent Loop BB0_15 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	lbu	a3, 0(s1)
	addw	a0, a0, a3
	addi	s0, s0, -1
	addi	s1, s1, 1
	bnez	s0, .LBB0_16
# %bb.17:                               # %"end for sum.s1.r4$x.us"
                                        #   in Loop: Header=BB0_15 Depth=3
	addi	a4, a4, 1
	addi	a2, a2, 543
	bne	a4, a5, .LBB0_15
# %bb.18:                               # %"consume sum.us"
                                        #   in Loop: Header=BB0_14 Depth=2
	slli	a2, a0, 32
	mulhu	a2, a2, a7
	srli	a2, a2, 32
	sub	a0, a0, a2
	srli	a0, a0, 1
	add	a0, a0, a2
	srli	a0, a0, 8
	add	a2, a1, t6
	add	a2, a2, t4
	sb	a0, 0(a2)
	addi	a1, a1, 1
	addi	s2, s2, 15
	bne	a1, t5, .LBB0_14
# %bb.19:                               # %"end for ascii_art.s0.x.rebased.loopexit.us"
                                        #   in Loop: Header=BB0_13 Depth=1
	addi	t3, t3, 1
	add	a6, a6, t0
	bne	t3, t2, .LBB0_13
.LBB0_20:                               # %destructor_block
	li	a0, 0
	ld	s0, 24(sp)                      # 8-byte Folded Reload
	ld	s1, 16(sp)                      # 8-byte Folded Reload
	ld	s2, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	ascii_art, .Lfunc_end0-ascii_art
                                        # -- End function
	.section	.text.ascii_art_argv,"ax",@progbits
	.globl	ascii_art_argv                  # -- Begin function ascii_art_argv
	.p2align	1
	.type	ascii_art_argv,@function
ascii_art_argv:                         # @ascii_art_argv
# %bb.0:                                # %entry
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	ld	a2, 0(a0)
	ld	a1, 8(a0)
	mv	a0, a2
	call	ascii_art@plt
	li	a0, 0
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	ascii_art_argv, .Lfunc_end1-ascii_art_argv
                                        # -- End function
	.section	.text.ascii_art_metadata,"ax",@progbits
	.globl	ascii_art_metadata              # -- Begin function ascii_art_metadata
	.p2align	1
	.type	ascii_art_metadata,@function
ascii_art_metadata:                     # @ascii_art_metadata
# %bb.0:                                # %entry
.Lpcrel_hi0:
	auipc	a0, %pcrel_hi(.Lascii_art_metadata_storage)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi0)
	ret
.Lfunc_end2:
	.size	ascii_art_metadata, .Lfunc_end2-ascii_art_metadata
                                        # -- End function
	.type	.Lstr,@object                   # @str
	.section	.rodata,"a",@progbits
	.p2align	5, 0x0
.Lstr:
	.asciz	"b0"
	.size	.Lstr, 3

	.type	.L__unnamed_1,@object           # @0
	.p2align	4, 0x0
.L__unnamed_1:
	.zero	32
	.size	.L__unnamed_1, 32

	.type	.Lstr.4,@object                 # @str.4
	.p2align	5, 0x0
.Lstr.4:
	.asciz	"ascii_art"
	.size	.Lstr.4, 10

	.type	.L__unnamed_2,@object           # @1
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
.L__unnamed_2:
	.quad	.Lstr
	.word	1                               # 0x1
	.word	2                               # 0x2
	.byte	1                               # 0x1
	.byte	8                               # 0x8
	.half	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.Lstr.4
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
	.size	.L__unnamed_2, 128

	.type	.Lstr.5,@object                 # @str.5
	.section	.rodata,"a",@progbits
	.p2align	5, 0x0
.Lstr.5:
	.asciz	"riscv-64-linux-no_asserts-no_runtime-rvv"
	.size	.Lstr.5, 41

	.type	.Lascii_art_metadata_storage,@object # @ascii_art_metadata_storage
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4, 0x0
.Lascii_art_metadata_storage:
	.word	1                               # 0x1
	.word	2                               # 0x2
	.quad	.L__unnamed_2
	.quad	.Lstr.5
	.quad	.Lstr.4
	.size	.Lascii_art_metadata_storage, 32

	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.ident	"clang version 16.0.0 (https://github.com/dkurt/llvm-rvv-071 b027aa1b59c9f53240bdc836f39656723fdf9df0)"
	.section	".note.GNU-stack","",@progbits
